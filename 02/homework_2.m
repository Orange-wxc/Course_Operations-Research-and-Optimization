% CREATED BY WXC ON 2020/12/9
% 描述：用第二周上机内容样例测试展示BFS，给出所有基本可行解及基矩阵
A = [2 1 1 0 0; 1 1 0 1 0; 0 1 0 0 1]; b = [10; 8; 7];
[xs, Bs, x_num] = BFS(A, b);
[m, n] = size(xs);
fprintf('共有 %d 组基本可行解\n\n', x_num);
for ii = 1 : x_num
    fprintf('第 %d 组基本可行解为：\n', ii);
    for jj = 1 : n
        s = strcat('x', num2str(jj));
        fprintf('%s = %d,  ', s, xs(ii, jj));
    end
    fprintf('\n');
    fprintf('对应基矩阵为：\n');
    disp(Bs(:, :, ii));
end

