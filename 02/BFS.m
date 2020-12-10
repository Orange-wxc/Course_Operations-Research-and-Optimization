% CREATED BY WXC ON 2020/12/9
% ��������LP����Ļ������н⼰�������
% ������   xs  ��ľ���ÿ�ж�Ӧһ��⣬һ������i��ֵ����xi
%          Bs  ���������ά������xs�е�ÿһ�н�һһ��Ӧ
%          x_num   �������н������
function [xs, Bs, x_num] = BFS(A, b)
    xs = []; Bs = []; x_num = 0;    % ��ʼ��
    [m, n] = size(A);
    combos = nchoosek(1 : n, m);    % ���������е��������
    [mc, nc] = size(combos);
    for ii = 1 : mc                  % ����ÿ����ϣ���ȡ��Ӧ�����ɱ�ѡ����                 
        tB = A(:, combos(ii, :));
        if det(tB) ~= 0             % ���ݾ����Ƿ�����ж��Ƿ�Ϊ������
            xb = inv(tB) * b;       % ����н�
            if xb >= 0              % ���ݽ��Ƿ�Ǹ��ж��Ƿ�Ϊ�������н�
                x = zeros(1, n);
                x_num = x_num + 1;
                x(:, combos(ii, :)) = xb';
                xs(x_num, :) = x;
                Bs(:, :, x_num) = tB;
            end
        end
    end
end
        
