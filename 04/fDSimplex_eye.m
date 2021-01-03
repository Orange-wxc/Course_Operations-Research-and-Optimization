% ���ö�ż�����η����LP����
% CREATED BY WXC ON 2020/12/26
% ���������ö�ż�����η���� LP ����
% ������       
%           x_opt   �����������Ž�
%           fx_opt  ���Ž�ĺ���ֵ
%           iter    ��������
% �����
%           �� �ɽ⣬�������������������
%           �� �޽⣺������ż������ż��������޽�⣬��ԭ�����޽�
%           �� �޽�� & ��⣺������

% A = [-1 -2 -1 1 0; -2 1 -3 0 1];
% b = [-3; -4];
% c = [-2; -3; -4; 0; 0];
A = [-1 -2 -1 1 0; -2 1 -3 0 1];
b = [-3; -4];
c = [-2; -3; -4; 0; 0];
[x_opt, fx_opt, iter] = DSimplex_eye(A, b, c)

function [x_opt, fx_opt, iter] = DSimplex_eye(A, b, c)
    
    % Ѱ�ҳ�ʼ�������н�
    % ��ʼ��������
    xB = [];        % ��Ż��������±�ţ�������
    B = [];         % ��Ż�����
    AA = [A b];     % ���ϵ������ A �� b ���������
    bb = b;         % ��� b ��������
    cc = c;         % ���Ŀ�꺯���и�������ϵ����������
    theta = [];     % ��� theta = min{sigma(j) / a(k, j) | a(k, j) < 0},������
    sigma = [];     % ��ż����� sigma 
    cB = [];        % ��Ż�������Ӧ�� c ֵ
    iter = 0;       % ��������

    [mA, nA] = size(A); 

    % Ѱ�ҵ�λ����
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
        fprintf('�Ҳ�����λ����\n');
        x_opt = -1; fx_opt = -1; iter = -1;
        return;
    end
    
    % �����ʼ�����α�� sigma
    for ii = 1:nA
        sigma(ii, 1) = cc(ii, 1) - cB' * AA(:, ii);
    end
    
    % �ж� DP �����Ƿ����
    if sigma <= 0

        % �� LP ������У����ҵ����Ž�
        while ~(sum(bb >= 0) == numel(bb))
            
            % ����������ѡȡ bb �и�ֵ����С�Ķ�Ӧ�Ļ�������Ϊ����
            xOutIndex = find(bb == min(bb(find(bb < 0))));
            % fprintf('����Ϊ��x%d\n', xB(xOutIndex));

            % ���� theta 
            theta = zeros(nA, 1);
            for ii = 1:nA
                if AA(xOutIndex, ii) < 0
                    theta(ii, 1) = sigma(ii, 1) / AA(xOutIndex, ii);
                end
            end
            
            % �ж� DP �����Ƿ�����޽�⣨ԭ�����Ƿ��н⣩
            % DP ��������޽�⣬������ max ��������ż����ԭ�����޽�
            if theta <= zeros(nA, 1)
                fprintf('DP ��������޽�⣬����ԭ�����޽⣡\n');
                x_opt = -1; fx_opt = -1; iter = -1;
                return
            % ���������ѡ���� 0 �� theta ����С�Ķ�Ӧ�ı�����Ϊ���
            else
                xInIndex = find(theta == min(theta(find(theta > 0))));
                xIn = xInIndex;
                % fprintf('���Ϊ��x%d\n', xIn);
            end
            
            % ����
            xB(xOutIndex, 1) = xIn;

            % �����б仯
            % ����ı�����ϵ��
            AA(xOutIndex, :) = AA(xOutIndex, :) / AA(xOutIndex, xInIndex);
            % �ǻ��������Ԫ
            for ii = 1:mA
                if ii ~=  xOutIndex
                    AA(ii, :) = AA(ii, :) - AA(ii, xInIndex) * AA(xOutIndex, :);
                end
            end
            
            % ���� b 
            bb = AA(:, nA + 1);

            % ���� sigma
            cB(:, 1) = cc(xB(:, 1), 1);
            for ii = 1:nA
                sigma(ii, 1) = cc(ii, 1) - cB' * AA(:, ii);
            end

            % ��������
            iter = iter + 1; 
            
        end
        
        % �����ֵ
        x_opt = zeros(nA, 1);
        x_opt(xB(:, 1), 1) = bb(:, 1);
        fx_opt = cc' * x_opt;
        
    else
        fprintf('sigma > 0�� DP �����е�λ�����Ӧ�ⲻ���У�\n'); 
        x_opt = -1; fx_opt = -1; iter = -1;
    end
    
end



% ��������
% ����
% A = [-1 -2 -1 1 0; -2 1 -3 0 1];
% b = [-3; -4];
% c = [-2; -3; -4; 0; 0];
% [x_opt, fx_opt, iter] = DSimplex_eye(A, b, c)

% ���ڶ�����Ž�
% A = [2 7 1 0; 7 2 0 1];
% b = [21; 21];
% c = [4; 14; 0; 0];
% [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)

% �����޽��
% A = [1 -1 1 0; -3 1 0 1];
% b = [2; 4];
% c = [2; 3; 0; 0];
% [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)

% ��λ�����Ӧ��ǿ���
% A = [2 1 0; 3 0 1];
% b = [-2; -3];
% c = [-1; -2; 0];
    
    

