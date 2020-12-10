% CREATED BY WXC ON 2020/12/9
% 描述：求LP问题的基本可行解及其基矩阵
% 参数：   xs  解的矩阵，每行对应一组解，一行中列i的值代表xi
%          Bs  基矩阵的三维矩阵，与xs中的每一行解一一对应
%          x_num   基本可行解的数量
function [xs, Bs, x_num] = BFS(A, b)
    xs = []; Bs = []; x_num = 0;    % 初始化
    [m, n] = size(A);
    combos = nchoosek(1 : n, m);    % 生成所有列的排列组合
    [mc, nc] = size(combos);
    for ii = 1 : mc                  % 遍历每个组合，提取对应列生成备选矩阵                 
        tB = A(:, combos(ii, :));
        if det(tB) ~= 0             % 根据矩阵是否可逆判断是否为基矩阵
            xb = inv(tB) * b;       % 求可行解
            if xb >= 0              % 根据解是否非负判断是否为基本可行解
                x = zeros(1, n);
                x_num = x_num + 1;
                x(:, combos(ii, :)) = xb';
                xs(x_num, :) = x;
                Bs(:, :, x_num) = tB;
            end
        end
    end
end
        
