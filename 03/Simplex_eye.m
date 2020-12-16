% CREATED BY WXC ON 2020/12/17
% 描述：利用单纯形法求解 LP 问题
% 参数：       
%           x_opt   列向量，最优解
%           fx_opt  最优解的函数值
%           iter    迭代次数
% 输出：
%           ① 可解，正常输出以上三个参数
%           ② 多解：存在多个最优解，仅输出一个解，但是提示存在多解
%           ③ 无界解：提示存在无界解

function [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)
    
    % 寻找初始基本可行解
    % 初始化各参数
    combos = [];    % 存放所有可能的基矩阵的列号的排列结果
    xB = [];        % 存放基变量的下标号，列向量
    B = [];         % 存放基矩阵
    AA = [A b];     % 存放系数矩阵 A 和 b 的增广矩阵
    bb = b;         % 存放 b ，列向量
    cc = c;         % 存放目标函数中各变量的系数，列向量
    theta = [];     % 存放 theta = min{b(i) / a(i, k) | a(i, k) > 0},列向量
    sigma = [];     % 存放检验数 sigma 
    cB = [];        % 存放基变量对应的 c 值
    iter = 0;       % 迭代次数

    [mA, nA] = size(A); 
    myEye = eye(mA);
    % 生成所有组合数
    tCombos = nchoosek(1:nA, mA);                   
    [mtCombos, ntCombos] = size(tCombos);
    % 对于每一个组合，生成排列
    for ii = 1:mtCombos                             
        combos = [combos; perms(tCombos(ii, :))];
    end
    
    [mCombos, nCombos] = size(combos);
    % 根据每一种排列生成一个矩阵，判断是否为单位矩阵（作为初始基本可行解）
    for ii = 1:mCombos      
        for jj = 1:nCombos  
            B(:, jj) = A(:, combos(ii, jj));
        end
        % 判断是否为单位矩阵（作为初始基本可行解）
        if B == myEye       
            xB = (combos(ii, :))';
            break;
        else
            continue;
        end
    end
    
    if isempty(xB)
        fprintf('找不到方便的初始基本可行解！\n');
        return
    else
        % 计算初始单纯性表的 cB 和 sigma
        cB(:, 1) = cc(xB(:, 1), 1);
        for ii = 1:nA
            sigma(ii, 1) = cc(ii, 1) - cB' * AA(:, ii);
        end
        
        % 循环直至非基变量 sigma 均小于等于0
        while max(sigma) > 0
            % 输出单纯性表中的系数、 sigma 、b ，便于观察
            disp(AA);
            disp(sigma');
            disp(bb);
            
            % 决定入基
            xIn = find(sigma == max(sigma(find(sigma > 0))));
            
            % 计算theta
            for ii = 1:mA
                theta(ii, 1) = bb(ii, 1) / AA(ii, xIn);
            end

            % 决定出基，选大于 0 的 theta 中最小的对应的变量作为出基
            t = find(theta > 0);
            % 判断是否找得到 theta 大于 0 的变量，找不到则说明没有出基，存在无界解
            if ~isempty(t)
                xOutIndex = find(theta == min(theta(t)));
                xOut = xB(xOutIndex, 1);
            else
                fprintf('存在无界解！\n');
                return
            end      
            
            % 换基
            xB(xOutIndex, 1) = xIn;
            
            % 消元解基本可行解
            % 换入的变量除系数
            AA(xOutIndex, :) = AA(xOutIndex, :) / AA(xOutIndex, xIn);
            % 非换入变量消元
            for ii = 1:mA
                if ii ~=  xOutIndex
                    AA(ii, :) = AA(ii, :) - AA(ii, xIn) * AA(xOutIndex, :);
                end
            end
            % 更新 b 
            bb = AA(:, nA + 1);
            
            % 更新 sigma
            cB(:, 1) = cc(xB(:, 1), 1);
            for ii = 1:nA
                sigma(ii, 1) = cc(ii, 1) - cB' * AA(:, ii);
            end
            
            % 迭代次数
            iter = iter + 1; 
            
        end
    end
    
    % 输出单纯性表中的系数、 sigma 、b ，便于观察
    disp(AA);
    disp(sigma');
    disp(bb);
    
    % 给输出参数赋值
    x_opt = zeros(nA, 1);
    x_opt(xB(:, 1), 1) = bb(:, 1);
    fx_opt = cc' * x_opt;
    
    % 判断是否存在多个最优解，即非基变量的 sigma 值为0
    for ii = 1:nA
        if ~ismember(ii, xB) && sigma(ii) == 0
            fprintf('存在多个最优解！\n');
        end
    end
    
end


% 测试用例
% 例题
% A = [2 -3 2 1 0; 1/3 1 5 0 1];
% b = [15; 20];
% c = [1; 2; 1; 0; 0];
% [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)

% 存在最优解
% A = [2 7 1 0; 7 2 0 1];
% b = [21; 21];
% c = [4; 14; 0; 0];
% [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)

% 存在无界解
% A = [1 -1 1 0; -3 1 0 1];
% b = [2; 4];
% c = [2; 3; 0; 0];
% [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)



