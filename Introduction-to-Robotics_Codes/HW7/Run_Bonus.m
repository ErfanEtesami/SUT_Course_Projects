clc;
clear;
close all;

%% Get input
fileID = fopen('input.txt', 'r');
% Get N
formatSpec = '%d';
N = fscanf(fileID, formatSpec, 1);
B = inf(N, 4);  % Initialize obstacles
% Get obstacles, Xs, and Xf
formatSpec = ['%f', ','];
for i = 2:2+N-1
    B(i-1, :) = fscanf(fileID, formatSpec);
end
Xs = fscanf(fileID, formatSpec);
Xf = fscanf(fileID, formatSpec);
% Get m 
formatSpec = '%d';
m = fscanf(fileID, formatSpec, 1);
Robot = inf(m, 2);  % Initialize the robot's vertices
% Get the robot's vertices
formatSpec = ['%f', ','];
for i = 1:m
    Robot(i, :) = fscanf(fileID, formatSpec);
end
fclose(fileID);

%% MS-2 - Define the robot's vectors
rep_vrtx = 1; % MS-1 - The robot's representative vertex
vecs = inf(m-1, 2); % Initialize the robot's vectors
row = 1;
for i = 1:m
    if i == rep_vrtx
        continue;
    end
    vecs(row, :) = Robot(rep_vrtx, :) - Robot(i, :);
    row = row + 1;
end

%% MS-3
obs = inf(2*N*m, 2); % Initialize obs
i = 1;
row = 1;
while i < size(obs, 1)
    obs(i, :) = B(row, 1:2);
    i = i + 1;
    for j = 1:size(vecs, 1)
        obs(i, :) = B(row, 1:2) + vecs(j, :);
        i = i + 1;
    end
    obs(i, :) = B(row, 3:4);
    i = i + 1;
    for j = 1:size(vecs, 1)
        obs(i, :) = B(row, 3:4) + vecs(j, :);
        i = i + 1;
    end
    row = row + 1;
end

%% Define convex hulls
MPL = 2*m;  % each initial obstacle has 2 vertices
cnvhull = cell(1, N);   % Initialize cnvhull
for i = 1:N
    cnvhull{i} = inf(MPL, 2);   % Initialize cnvhull
    unseen_vrtcs = 1:MPL;
    row = 1;
    % Find nodes associated with each initial obstacle
    Q = obs((i-1)*MPL+1:i*MPL, :);
    % CH-1 - find q1
    [q1x, q1x_loc] = min(Q(:, 1));
    [min_i, min_j] = ind2sub(size(Q(:, 1)), q1x_loc);
    q1 = [q1x, Q(min_i, min_j+1)];
    % CH-2 - define qL
    qL = q1 - [1, 0];
    % CH-3 - define qC
    cnvhull{i}(row, :) = q1;
    % CH-4
    while true
        alpha = inf(1, MPL);    % Initialize alpha
        for j = unseen_vrtcs
            u = [qL - cnvhull{i}(row, :), 0];
            v = [Q(j, :) - cnvhull{i}(row, :), 0];
            temp_sin = dot(cross(u, v), [0, 0, -1]) / (norm(u)*norm(v));
            temp_cos = dot(u, v) / (norm(u)*norm(v));
            alpha(j) = atan2d(temp_sin, temp_cos); 
        end
        % Find suitable alpha for qN definition
        if any(and(alpha > 0, alpha ~= inf))
            alpha_min = min(alpha(alpha > 0));
            alpha_min_loc = find(alpha == alpha_min);
        else
            [alpha_min, alpha_min_loc] = min(alpha);
        end
        % define qN
        qN = Q(alpha_min_loc, :);
        % CH-5
        if isequal(qN, q1)
            row = row + 1;
            cnvhull{i}(row, :) = q1;    % Add q1 to the end of cnvhull
            cnvhull{i}(row+1:end, :) = [];  % Remove extra undesired elements of cnvhull
            break;
        else
            qL = cnvhull{i}(row, :);
            row = row + 1;
            cnvhull{i}(row, :) = qN;
            unseen_vrtcs(unseen_vrtcs == alpha_min_loc) = [];
        end
        % end if
    end
    % end while
end
% end for

%% Define Nodes
num_Nodes = 2;  % Xs and Xf
for i = 1:N
    num_Nodes = num_Nodes + length(cnvhull{i}) - 1;
end
Nodes = inf(num_Nodes, 4);  % Initialize Nodes
% First node -> Xs
Nodes(1, 1:3) = [1, Xs(1), Xs(2)];
% Last node -> Xf
Nodes(end, 1:3) = [num_Nodes, Xf(1), Xf(2)];
Nodes(end, 4) = 0;
% Other nodes -> convex hulls' vertices
for i = 1:N
    row = 1;
    num = length(cnvhull{i}) - 1;
    for j = (i-1)*num+2:i*num+1
        Nodes(j, 1) = j;
        Nodes(j, 2:3) = cnvhull{i}(row, :);
        row = row + 1;
    end
end

%% Define diagonals (edges which are inside each convex hull)
num_diag = 0;
for i = 1:N
    num = length(cnvhull{i}) - 1;
    num_diag = num_diag + num * (num-3) / 2;
end
diagonals = zeros(num_diag, 2); % Initialize diagonals
row = 1;
for i = 1:N
    num = length(cnvhull{i}) - 1;
    for j = (i-1)*num+2:i*num+1-2
        if j == (i-1)*num+2
            for k = j+2:i*num+1-1
                diagonals(row, :) = [j, k];
                row = row + 1;
            end
            continue;
        end
        for k = j+2:i*num+1
            diagonals(row, :) = [j, k];
            row = row + 1;
        end
    end
end

%% Check if Xf is inside a convex hull
for i = 1:N
    xv = cnvhull{i}(1:end-1, 1);
    yv = cnvhull{i}(1:end-1, 2);
    [in, on] = inpolygon(Xf(1), Xf(2), xv, yv);
    if in==1 && on==0
        fprintf('Unreachable in Reality: Xf is in Convexhull #%d.\n', i);
    end
end

%% Define Edges
Edges = inf(num_Nodes*(num_Nodes-1)/2, 4);  % Initialize Edges
row_Edges = 1;
for i = 1:num_Nodes-1
    S = [Nodes(i, 2); Nodes(i, 3)];
    for j = i+1:num_Nodes
        % Remove diagonals from Edges
        index1 = and(any(diagonals == i, 2), any(diagonals == j, 2));
        index2 = find(index1 == 1);
        if index2
            continue;
        end
        
        flag = 1;
        T = [Nodes(j, 2); Nodes(j, 3)]; 
        
        flag2 = 1;
        for k = 1:N
            xq = [S(1), T(1)];
            yq = [S(2), T(2)];
            xv = cnvhull{k}(1:end-1, 1);
            yv = cnvhull{k}(1:end-1, 2);
            [xi, yi] = polyxpoly(xq, yq, xv, yv);
            [in, on] = inpolygon(xq, yq, xv, yv);
            if j == num_Nodes && isequal(on, [1, 1])
                for l = 1:length(xv)
                    A = [cnvhull{k}(l, 1); cnvhull{k}(l, 2)];       % First vertex of a obstacle
                    C = [cnvhull{k}(l+1, 1); cnvhull{k}(l+1, 2)];   % Second vertex of a obstacle
                    tempAC = A' - C';
                    tempAT = A' - T';
                    tempST = S' - T';
                    if norm(cross([tempAT, 0], [tempAC, 0]))==0 && norm(cross([tempST, 0], [tempAC, 0]))~=0
                        flag2 = 0;
                        break;
                    end
                end
                % end for
            end
            % end if
            if length(xi) > 1 && ~isequal(on, [1, 1])
                flag2 = 0;
                break;
            end
        end
        % end for
        if flag2 == 0
            continue;
        end
        
        tempST = S' - T';
        for k = 1:N
            for l = 1:length(cnvhull{k})-1
                A = [cnvhull{k}(l, 1); cnvhull{k}(l, 2)];       % First vertex of a obstacle
                C = [cnvhull{k}(l+1, 1); cnvhull{k}(l+1, 2)];   % Second vertex of a obstacle
                tempAC = A' - C';
                if norm(cross([tempST, 0], [tempAC, 0])) == 0 && (isequal(S, A) || isequal(S, C))
                    continue;
                end
                U = [A-C, -(S-T)];
                par = U \ (T-C);
                par1 = par(1);
                par2 = par(2);
                par1 = round(par1, 2);
                par2 = round(par2, 2);
                cond1 = par1>0 && par1<1;
                cond2 = par2>0 && par2<1;
                % Condition of par (alpha or beta)
                if cond1 && cond2
                    flag = 0;
                    break;
                end
            end
            % end for
            if flag == 0
                break;
            end
        end
        % end for
        if flag == 1
            Edges(row_Edges, 1:3) = [row_Edges, Nodes(i, 1), Nodes(j, 1)];
            row_Edges = row_Edges + 1;
        end
    end
    % end for
end
% end for
% Remove extra undesired elements of the path
Edges(:, 4) = 0;
Edges = Edges(~any(isinf(Edges), 2), :); 
num_Edges = size(Edges, 1);

%% Dijkstra Algorithm
unseen_Nodes = Nodes(:, 1); % DA-1-2
current_Node_ID = Nodes(end, 1);    % DA-1-3
% Initialize the path
path = inf(1, num_Nodes);
path(1) = current_Node_ID;
count = 2;
while true
    % DA-1-4 - Find neighbor nodes
    neighbor_Node_IDs = [Edges(current_Node_ID == Edges(:, 2), 3);
                         Edges(current_Node_ID == Edges(:, 3), 2)];
    % DA-1-4 - Find neighbor nodes that have not been seen                 
    neighbor_Node_IDs = intersect(neighbor_Node_IDs, unseen_Nodes);
    % DA-1-4 - Check if there is not any unseen neighbor node
    if isempty(neighbor_Node_IDs)
        unseen_Nodes(unseen_Nodes == current_Node_ID) = [];
        if ~isempty(unseen_Nodes)
            current_Node_ID = unseen_Nodes(end);
            continue;
        end
    end
    % DA-1-4 - Continue
    num_Neighbors = length(neighbor_Node_IDs);
    dist = inf(num_Neighbors, 1);
    for i = 1:num_Neighbors
        current_Neighbor_Node_ID = find(neighbor_Node_IDs(i) == Nodes(:, 1));
        weight = norm(Nodes(current_Node_ID, 2:3) - Nodes(current_Neighbor_Node_ID, 2:3));
        index1 = and(any(Edges(:, 2:3)==current_Node_ID, 2), any(Edges(:, 2:3)==current_Neighbor_Node_ID, 2));
        index2 = find(index1 == 1);
        Edges(index2, 4) = weight;
        temp = weight + Nodes(current_Node_ID, 4);
        if Nodes(current_Neighbor_Node_ID, 4) > temp
            Nodes(current_Neighbor_Node_ID, 4) = temp;
        end
        dist(i) = Nodes(current_Neighbor_Node_ID, 4);
    end
    % DA-1-5
    unseen_Nodes(unseen_Nodes == current_Node_ID) = [];
    % DA-1-6 - Check if any node is left
    if isempty(unseen_Nodes)
        break;
    end
    % DA-1-6 - Continue
    [min_dist, min_dist_loc] = min(dist(:));
    current_Node_ID = find(neighbor_Node_IDs(min_dist_loc) == Nodes(:, 1));
    path(count) = current_Node_ID;
    % Next iteration
    count = count + 1;
end
% end while

%% Find the shortest path
current_Node_ID = Nodes(1, 1);  % DA-2-1
% Initialize the shortest path
Path = inf(num_Nodes, 1);
Path(1) = current_Node_ID;
count = 2;
while true
    % DA-2-2 - Find neighbor nodes
    neighbor_Node_IDs = [Edges(current_Node_ID == Edges(:, 2), 3);
                         Edges(current_Node_ID == Edges(:, 3), 2)];
    % DA-2-2 - Continue                 
    num_Neighbors = length(neighbor_Node_IDs);
    for i = 1:num_Neighbors
        current_Neighbor_Node_ID = find(neighbor_Node_IDs(i) == Nodes(:, 1));
        index1 = and(any(Edges(:, 2:3)==current_Node_ID, 2), any(Edges(:, 2:3)==current_Neighbor_Node_ID, 2));
        index2 = find(index1 == 1);
        weight = Edges(index2, 4);
        if Nodes(current_Neighbor_Node_ID, 4) + weight == Nodes(current_Node_ID, 4)
            current_Node_ID = current_Neighbor_Node_ID;
            Path(count) = current_Node_ID;
            break;
        end
    end
    % DA-2-3
    if current_Node_ID == Nodes(end, 1)
        break;
    end
    % Next iteration
    count = count + 1;
end
% end while
% Remove extra undesired elements of Path
Path = Path(~any(isinf(Path), 2), :); 

%% Plot
figure;
hold on;
grid on;
box on;
axis equal;
xlabel('$X$', 'Interpreter', 'latex');
ylabel('$Y$', 'Interpreter', 'latex');
title('$Dijkstra\ Algorithm\ (Bonus\ Part)$', 'Interpreter', 'latex');
plot(Xs(1), Xs(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
plot(Xf(1), Xf(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
% Plot initial obstacles
for i = 1:N
    plot([B(i, 1), B(i, 3)], [B(i, 2), B(i, 4)], 'LineWidth', 2);
end
% Plot Robot
% for i = 1:m
%     if i == m
%         plot([Robot(1, 1), Robot(m, 1)], [Robot(1, 2), Robot(m, 2)], 'Color', [0.4940 0.1840 0.5560]);
%         break;
%     end
%     plot([Robot(i, 1), Robot(i+1, 1)], [Robot(i, 2), Robot(i+1, 2)], 'Color', [0.4940 0.1840 0.5560]);
% end
% Plot convex hulls
for i = 1:N
    for j = 1:size(cnvhull{i}, 1)
        if j == size(cnvhull{i}, 1)
            plot([cnvhull{i}(1, 1), cnvhull{i}(end, 1)], [cnvhull{i}(1, 2), cnvhull{i}(end, 2)], '--', 'LineWidth', 1.5, 'Color', [0.6350 0.0780 0.1840]);
            break;
        end
        plot([cnvhull{i}(j, 1), cnvhull{i}(j+1, 1)], [cnvhull{i}(j, 2), cnvhull{i}(j+1, 2)], '--', 'LineWidth', 1.5, 'Color', [0.6350 0.0780 0.1840]);
    end
end
% Plot Edges
% for i = 1:num_Edges
%     j = Edges(i, 2);
%     k = Edges(i, 3);
%     plot([Nodes(j, 2), Nodes(k,2)], [Nodes(j, 3), Nodes(k, 3)], 'k--');
% end
% Plot the shortest path
for i = 1:length(Path)-1
    plot([Nodes(Path(i), 2), Nodes(Path(i+1),2)], [Nodes(Path(i), 3), Nodes(Path(i+1), 3)],... 
         'LineWidth', 1, 'Color', [0 0.4470 0.7410]);
end
