% CREATED BY WXC ON 2020/12/9
% �������õڶ����ϻ�������������չʾBFS���������л������н⼰������
A = [2 1 1 0 0; 1 1 0 1 0; 0 1 0 0 1]; b = [10; 8; 7];
[xs, Bs, x_num] = BFS(A, b);
[m, n] = size(xs);
fprintf('���� %d ��������н�\n\n', x_num);
for ii = 1 : x_num
    fprintf('�� %d ��������н�Ϊ��\n', ii);
    for jj = 1 : n
        s = strcat('x', num2str(jj));
        fprintf('%s = %d,  ', s, xs(ii, jj));
    end
    fprintf('\n');
    fprintf('��Ӧ������Ϊ��\n');
    disp(Bs(:, :, ii));
end

