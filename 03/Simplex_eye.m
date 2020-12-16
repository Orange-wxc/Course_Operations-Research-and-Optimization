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

function [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)
    
    % Ѱ�ҳ�ʼ�������н�
    % ��ʼ��������
    combos = [];    % ������п��ܵĻ�������кŵ����н��
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
    myEye = eye(mA);
    % �������������
    tCombos = nchoosek(1:nA, mA);                   
    [mtCombos, ntCombos] = size(tCombos);
    % ����ÿһ����ϣ���������
    for ii = 1:mtCombos                             
        combos = [combos; perms(tCombos(ii, :))];
    end
    
    [mCombos, nCombos] = size(combos);
    % ����ÿһ����������һ�������ж��Ƿ�Ϊ��λ������Ϊ��ʼ�������н⣩
    for ii = 1:mCombos      
        for jj = 1:nCombos  
            B(:, jj) = A(:, combos(ii, jj));
        end
        % �ж��Ƿ�Ϊ��λ������Ϊ��ʼ�������н⣩
        if B == myEye       
            xB = (combos(ii, :))';
            break;
        else
            continue;
        end
    end
    
    if isempty(xB)
        fprintf('�Ҳ�������ĳ�ʼ�������н⣡\n');
        return
    else
        % �����ʼ�����Ա�� cB �� sigma
        cB(:, 1) = cc(xB(:, 1), 1);
        for ii = 1:nA
            sigma(ii, 1) = cc(ii, 1) - cB' * AA(:, ii);
        end
        
        % ѭ��ֱ���ǻ����� sigma ��С�ڵ���0
        while max(sigma) > 0
            % ��������Ա��е�ϵ���� sigma ��b �����ڹ۲�
            disp(AA);
            disp(sigma');
            disp(bb);
            
            % �������
            xIn = find(sigma == max(sigma(find(sigma > 0))));
            
            % ����theta
            for ii = 1:mA
                theta(ii, 1) = bb(ii, 1) / AA(ii, xIn);
            end

            % ����������ѡ���� 0 �� theta ����С�Ķ�Ӧ�ı�����Ϊ����
            t = find(theta > 0);
            % �ж��Ƿ��ҵõ� theta ���� 0 �ı������Ҳ�����˵��û�г����������޽��
            if ~isempty(t)
                xOutIndex = find(theta == min(theta(t)));
                xOut = xB(xOutIndex, 1);
            else
                fprintf('�����޽�⣡\n');
                return
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
    end
    
    % ��������Ա��е�ϵ���� sigma ��b �����ڹ۲�
    disp(AA);
    disp(sigma');
    disp(bb);
    
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

% �������Ž�
% A = [2 7 1 0; 7 2 0 1];
% b = [21; 21];
% c = [4; 14; 0; 0];
% [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)

% �����޽��
% A = [1 -1 1 0; -3 1 0 1];
% b = [2; 4];
% c = [2; 3; 0; 0];
% [x_opt, fx_opt, iter] = Simplex_eye(A, b, c)



