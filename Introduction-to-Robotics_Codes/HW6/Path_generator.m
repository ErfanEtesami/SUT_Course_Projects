function P = Path_generator(Xs, Xf, Eta, B, flag)
% Path generation for a point moving on a plane which has some obstacles.
% Without Random Walk: flag = 0, With Random Walk: flag = 1

Epsilon = 0.1;      % for PFA
Threshold = 0.1;    % for PFA
flag2 = 0;  % for random walk

% define the path with maximum possible elements (guess)
max_possible_length = 1e5;
P = inf(max_possible_length, 2);

% initialization
j = 1;
P(j, :) = Xs';

% generating the path
while norm(P(j, :) - Xf') >= Threshold
    Fatt = (-Eta * (P(j, :) - Xf'))';   % attractive Field
    
    sum_Frep = [0; 0];  % sum of repulsive fields
    
    % obstacle avoidance
    for i = 1:size(B, 1)
        % find Bi
        A = [B(i, 1); B(i, 2)]; % first vertex of a obstacle
        C = [B(i, 3); B(i, 4)]; % second vertex of a obstacle
        AmC = A - C;
        D = [AmC, -[0, -1; 1, 0]*AmC];
        par = D \ (P(j, :)-C')';
        par1 = par(1);
        H = AmC * par1 + C;
        
        % conditions of par1 (alpha)
        if par1 < 0
            isc = C;    % isc: intersection
        elseif par1>=0 && par1<=1
            isc = H;    % isc: intersection
        else
            isc = A;    % isc: intersection
        end
        
        % rho_i
        rho = norm(P(j, :) - isc');
        
        % Frep_i
        if rho <= B(i, 5)
            Frep = (B(i, 6)/(rho^3)) * ((1/rho)-(1/B(i, 5))) * (P(j, :)-isc')';
        else
            Frep = [0; 0];
        end
        
        sum_Frep = sum_Frep + Frep;
    end
    % end for
    
    % find local minima
    direction = dot(Fatt, sum_Frep) / (norm(Fatt) * norm(sum_Frep));
    % specific condition
    cond = 0;
    Threshold2 = 0.05;
    if j >= 4
        cond = abs(P(j, 1)-P(j-1, 1))<Threshold2 &&... 
               abs(P(j, 1)-P(j-2, 1))<Threshold2 &&... 
               abs(P(j, 1)-P(j-3, 1))<Threshold2;
    end
%     if direction == -1 || cond
    if round(direction, 2) == -1 || cond
        if flag == 0    % without random walk
            fprintf('Stuck in local minima @ x = %.4f, y = %.4f\n', P(j, 1), P(j, 2));
            break;
        else % with random walk
            fprintf('local minima @ x = %.4f, y = %.4f\n', P(j, 1), P(j, 2));
            Threshold_RW = 0.5; % for the special cases 2 & 3
            [x_temp, y_temp, flag2] = Random_walk(P, j, B, Threshold_RW, Xf);
        end
    end
    
    if flag==1 && flag2==1  % with random walk after finding the suitable jump
        P(j+1, :) = [x_temp; y_temp]';
        flag2 = 0;
    elseif flag==1 && flag2==2  %
        P(j+1, :) = [x_temp, y_temp]';
        break;
    else % without random walk
        F = Fatt + sum_Frep;
        Fdrive = F / norm(F);
        P(j+1, :) = P(j, :) + (Epsilon * Fdrive)';
    end
    
    j = j + 1;
end

% remove extra undesired elements of the path
P = P(~any(isinf(P), 2), :);    

end
