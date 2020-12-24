% CREATED BY WXC ON 2020/12/17
% ���������õ����η���� LP ����
% ������       
%           x_opt   �����������Ž�
%           fx_opt  ���Ž�ĺ���ֵ
%           iter    ��������
% �����
%           �� �ɽ⣬�������������������
%           �� ��⣺���ڶ�����Ž⣬�����һ���⣬������ʾ���ڶ��
%           �� �޽�⣺��ʾ�����޽��
%           �� �޽⣺������

function [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)
    
    % Ѱ�ҳ�ʼ�������н�
    % ��ʼ��������
    xB = [];        % ��Ż��������±�ţ�������
    B = [];         % ��Ż�����
    AA = [A b];     % ���ϵ������ A �� b ���������
    bb = b;         % ��� b ��������
    cc = c;         % ���Ŀ�꺯���и�������ϵ����������
    theta = [];     % ��� theta = min{b(i) / a(i, k) | a(i, k) > 0},������
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

    % ѭ��ֱ���ǻ����� sigma ��С�ڵ���0
    while max(sigma) > 0
        % ��������Ա��е�ϵ���� sigma ��b �����ڹ۲�
        disp(AA);
        disp(sigma');
        disp(bb');

        % �������
        xIn = find(sigma == max(sigma(find(sigma > 0))));

        % ����theta
        theta = zeros(mA, 1);
        for ii = 1:mA
            if AA(ii, xIn) > 0
                theta(ii, 1) = bb(ii, 1) / AA(ii, xIn);
            end
        end

        % ����������ѡ���� 0 �� theta ����С�Ķ�Ӧ�ı�����Ϊ����
        % �ж� theta �Ƿ�ȫΪ 0 ����û�д��� 0 �� theta ��������޽��
        if theta == zeros(mA, 1)
            fprintf('�����޽�⣡\n');
            x_opt = -1; fx_opt = -1; iter = -1;
            return
        else
            xOutIndex = find(theta == min(theta(find(theta > 0))));
            xOut = xB(xOutIndex, 1);
        end      

        % ����
        xB(xOutIndex, 1) = xIn;

        % ��Ԫ��������н�
        % ����ı�����ϵ��
        AA(xOutIndex, :) = AA(xOutIndex, :) / AA(xOutIndex, xIn);
        % �ǻ��������Ԫ
        for ii = 1:mA
            if ii ~=  xOutIndex
                AA(ii, :) = AA(ii, :) - AA(ii, xIn) * AA(xOutIndex, :);
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

    % ��������Ա��е�ϵ���� sigma ��b �����ڹ۲�
    disp(AA);
    disp(sigma');
    disp(bb');
    
    % �����������ֵ
    x_opt = zeros(nA, 1);
    x_opt(xB(:, 1), 1) = bb(:, 1);
    fx_opt = cc' * x_opt;
    
    % �ж��Ƿ���ڶ�����Ž⣬���ǻ������� sigma ֵΪ0
    for ii = 1:nA
        if ~ismember(ii, xB) && sigma(ii) == 0
            fprintf('���ڶ�����Ž⣡\n');
        end
    end
    
end


% ��������
% ����
% A = [2 -3 2 1 0; 1/3 1 5 0 1];
% b = [15; 20];
% c = [1; 2; 1; 0; 0];
% [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)

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



%     combos = [];    % ������п��ܵĻ�������кŵ����н��
%     % �������������
%     tCombos = nchoosek(1:nA, mA);                   
%     [mtCombos, ntCombos] = size(tCombos);
%     % ����ÿһ����ϣ���������
%     for ii = 1:mtCombos                             
%         combos = [combos; perms(tCombos(ii, :))];
%     end
%     [mCombos, nCombos] = size(combos);
%     % ����ÿһ����������һ�������ж��Ƿ�Ϊ��λ������Ϊ��ʼ�������н⣩
%     for ii = 1:mCombos      
%         for jj = 1:nCombos  
%             B(:, jj) = A(:, combos(ii, jj));
%         end
%         % �ж��Ƿ�Ϊ��λ������Ϊ��ʼ�������н⣩
%         if B == myEye       
%             xB = (combos(ii, :))';
%             break;
%         else
%             continue;
%         end
%     end

