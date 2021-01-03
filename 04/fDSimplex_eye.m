% 利用对偶单纯形法解决LP问题
% CREATED BY WXC ON 2020/12/26
% 描述：利用对偶单纯形法求解 LP 问题
% 参数：       
%           x_opt   列向量，最优解
%           fx_opt  最优解的函数值
%           iter    迭代次数
% 输出：
%           ① 可解，正常输出以上三个参数
%           ② 无解：由弱对偶定理，对偶问题存在无界解，则原问题无解
%           ③ 无界解 & 多解：待完善

% A = [-1 -2 -1 1 0; -2 1 -3 0 1];
% b = [-3; -4];
% c = [-2; -3; -4; 0; 0];
A = [-1 -2 -1 1 0; -2 1 -3 0 1];
b = [-3; -4];
c = [-2; -3; -4; 0; 0];
[x_opt, fx_opt, iter] = DSimplex_eye(A, b, c)

function [x_opt, fx_opt, iter] = DSimplex_eye(A, b, c)
    
    % 寻找初始基本可行解
    % 初始化各参数
    xB = [];        % 存放基变量的下标号，列向量
    B = [];         % 存放基矩阵
    AA = [A b];     % 存放系数矩阵 A 和 b 的增广矩阵
    bb = b;         % 存放 b ，列向量
    cc = c;         % 存放目标函数中各变量的系数，列向量
    theta = [];     % 存放 theta = min{sigma(j) / a(k, j) | a(k, j) < 0},列向量
    sigma = [];     % 存放检验数 sigma 
    cB = [];        % 存放基变量对应的 c 值
    iter = 0;       % 迭代次数

    [mA, nA] = size(A); 

    % 寻找单位矩阵
    E = eye(mA);
    for ii = 1:mA
        for jj = 1:nA
            if A(ii, jj) == 1 & A(:, jj) == E(:, ii)
                xB(ii, 1) = jj;
                cB(ii, 1) = cc(jj, 1);
            end
        end
    end

    [mxB, nxB] = size(xB);
    if mxB < mA 
        fprintf('找不到单位矩阵！\n');
        x_opt = -1; fx_opt = -1; iter = -1;
        return;
    end
    
    % 计算初始单纯形表的 sigma
    for ii = 1:nA
        sigma(ii, 1) = cc(ii, 1) - cB' * AA(:, ii);
    end
    
    % 判断 DP 问题是否可行
    if sigma <= 0

        % 若 LP 问题可行，则找到最优解
        while ~(sum(bb >= 0) == numel(bb))
            
            % 决定出基，选取 bb 中负值且最小的对应的基变量作为出基
            xOutIndex = find(bb == min(bb(find(bb < 0))));
            % fprintf('出基为：x%d\n', xB(xOutIndex));

            % 计算 theta 
            theta = zeros(nA, 1);
            for ii = 1:nA
                if AA(xOutIndex, ii) < 0
                    theta(ii, 1) = sigma(ii, 1) / AA(xOutIndex, ii);
                end
            end
            
            % 判断 DP 问题是否存在无界解（原问题是否有解）
            % DP 问题存在无界解，本题求 max ，由弱对偶定理，原问题无解
            if theta <= zeros(nA, 1)
                fprintf('DP 问题存在无界解，本题原问题无解！\n');
                x_opt = -1; fx_opt = -1; iter = -1;
                return
            % 决定入基，选大于 0 的 theta 中最小的对应的变量作为入基
            else
                xInIndex = find(theta == min(theta(find(theta > 0))));
                xIn = xInIndex;
                % fprintf('入基为：x%d\n', xIn);
            end
            
            % 换基
            xB(xOutIndex, 1) = xIn;

            % 初等行变化
            % 换入的变量除系数
            AA(xOutIndex, :) = AA(xOutIndex, :) / AA(xOutIndex, xInIndex);
            % 非换入变量消元
            for ii = 1:mA
                if ii ~=  xOutIndex
                    AA(ii, :) = AA(ii, :) - AA(ii, xInIndex) * AA(xOutIndex, :);
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
        
        % 输出赋值
        x_opt = zeros(nA, 1);
        x_opt(xB(:, 1), 1) = bb(:, 1);
        fx_opt = cc' * x_opt;
        
    else
        fprintf('sigma > 0， DP 问题中单位矩阵对应解不可行！\n'); 
        x_opt = -1; fx_opt = -1; iter = -1;
    end
    
end



% 测试用例
% 例题
% A = [-1 -2 -1 1 0; -2 1 -3 0 1];
% b = [-3; -4];
% c = [-2; -3; -4; 0; 0];
% [x_opt, fx_opt, iter] = DSimplex_eye(A, b, c)

% 存在多个最优解
% A = [2 7 1 0; 7 2 0 1];
% b = [21; 21];
% c = [4; 14; 0; 0];
% [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)

% 存在无界解
% A = [1 -1 1 0; -3 1 0 1];
% b = [2; 4];
% c = [2; 3; 0; 0];
% [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)

% 单位矩阵对应解非可行
% A = [2 1 0; 3 0 1];
% b = [-2; -3];
% c = [-1; -2; 0];
    
    

