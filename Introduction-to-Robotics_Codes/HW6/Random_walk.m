function [x_temp, y_temp, flag2] = Random_walk(Path, j, B, Threshold, Xf)
% Random Walk Algorithm

a = 6;  % maximum length of jump
n = size(B, 1);

% find distance to vertices of obstacles
dist = inf(n, 2);
for i = 1:n
    A = [B(i, 1); B(i, 2)]; % first vertex of a obstacle
    C = [B(i, 3); B(i, 4)]; % second vertex of a obstacle
    dist(i, 1) = norm(Path(j, :) - A');
    dist(i, 2) = norm(Path(j, :) - C');
end

% find the nearest vertex
[min_dist, min_dist_loc] = min(dist(:));
[min_i, min_j] = ind2sub(size(dist), min_dist_loc);
if min_j == 1
    temp = [B(min_i, 1); B(min_i, 2)];
else
    temp = [B(min_i, 3); B(min_i, 4)];
end

% definition of the minimum desired angle of the jump
angle_seed = atan2(temp(2)-Path(j, 2), temp(1)-Path(j, 1));

% find the suitable jump
count1 = 0;     % for the special case 2
cst3 = 2;       % for the special case 2
cst4 = 2;       % for the special cases 3 & 4
count2 = 0;     % for the special cases 3 & 4
while true
    flag2 = 1;
    
    % find length of the jump
    min_dist = min_dist + 0.1;  % add 0.1 (conservative)
    if a >= min_dist
        jump = min_dist + (a-min_dist) * rand;  % length of the jump
    else
        jump = a * rand;    % length of the jump
    end
    
    % add a constasnt to angle_seed to make sure that after the jump, 
    % the generated path will not collide with the obstacle.
    cst1 = pi/36;      % equal to 5 degrees
    cst2 = 2 * pi/180; % equal to 2 degrees
    
    % different conditions
    % condition 1
    if min_j==2 && Path(j, 2)<=temp(2) && angle_seed>=0 && angle_seed<=pi/2 
        angle = angle_seed + cst2 + cst1 * rand;    % angle of the jump
        count1 = count1 + 1;
        if count1 == cst3 % for the special case 2
            jump = abs(Path(j, 2)-temp(2)) + norm(B(min_i, 1:2)-B(min_i, 3:4)) + Threshold; % length of the jump
            angle = -pi/2;  % angle of the jump - downward
        end
    % condition 2
    elseif min_j==2 && Path(j, 2)>temp(2) && angle_seed<0 && angle_seed>=-pi/2  
        angle = angle_seed + cst2 + cst1 * rand;    % angle of the jump
        count1 = count1 + 1;
        if count1 == cst3 % for the special case 2
            jump = abs(Path(j, 2)-temp(2)) + norm(B(min_i, 1:2)-B(min_i, 3:4)) + Threshold; % length of the jump
            angle = -pi/2;  % angle of the jump - downward
        end
    % condition 3
    elseif min_j==1 && Path(j, 2)>=temp(2) && angle_seed<=0 && angle_seed>=-pi/2  
        angle = angle_seed - cst2 - cst1 * rand;    % angle of the jump
        count1 = count1 + 1;
        if count1 == cst3 % for the special case 2
            jump = abs(Path(j, 2)-temp(2)) + norm(B(min_i, 1:2)-B(min_i, 3:4)) + Threshold; % length of the jump
            angle = pi/2;  % angle of the jump - upward
        end
    % condition 4
    elseif min_j==1 && Path(j, 2)<temp(2) && angle_seed>0 && angle_seed<=pi/2
        angle = angle_seed - cst2 - cst1 * rand;    % angle of the jump
        count1 = count1 + 1;
        if count1 == cst3 % for the special case 2
            jump = abs(Path(j, 2)-temp(2)) + norm(B(min_i, 1:2)-B(min_i, 3:4)) + Threshold; % length of the jump
            angle = pi/2;  % angle of the jump - upward
        end
    % the special case 1
    elseif Path(j, 1) > Xf(1)   
        disp('The robot has passed Xf!!!');
        x_temp = Path(j, 1);
        y_temp = Path(j, 2);
        flag2 = 2;
        break;
    % the special cases 3 & 4
    else
        % the special case 4
        count2 = count2 + 1;
        if count2 == cst4
            disp('Undefined error!!!');
            x_temp = Path(j, 1);
            y_temp = Path(j, 2);
            flag2 = 2;
            break;
        % the special case 3
        elseif min_j == 2
            jump = norm(B(min_i, 1:2)-B(min_i, 3:4))/2 + Threshold; % length of the jump
            angle = pi/2;   % angle of the jump - upward
        elseif min_j == 1
            jump =  norm(B(min_i, 1:2)-B(min_i, 3:4))/2 + Threshold; % length of the jump
            angle = -pi/2;  % angle of the jump - downward
        end
    end
    % end if
    
    % generated coordinate after the jump
    x_temp = Path(j, 1) + jump * cos(angle);
    y_temp = Path(j, 2) + jump * sin(angle);
    
    % obstacle avoidance
    for i = 1:n
        A = [B(i, 1); B(i, 2)]; % first vertex of a obstacle
        C = [B(i, 3); B(i, 4)]; % second vertex of a obstacle
        S = Path(j, :)';        % current point in the parh
        T = [x_temp; y_temp];   % generated coordinate after the jump
        U = [A-C, -(S-T)];
        par = U \ (T-C);
        
        % for the special case 2
        if count1 == cst3
            par = par(2);
        else
            par = par(1);
        end
        
        % condition of par (alpha or beta)
        if par>=0 && par<=1
            flag2 = 0;
            break;
        end
    end
    % end for
    
    if flag2 == 0
        continue;
    else
        break;
    end
end
% end while

end
