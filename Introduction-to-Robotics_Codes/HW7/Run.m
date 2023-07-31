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
fclose(fileID);

%% Define Nodes
% Each liner obstacle has two vertices
num_Nodes = 2*N + 2; % Vertices plus Xs and Xf
Nodes = inf(num_Nodes, 4);  % Initialize Nodes
% First node -> Xs
Nodes(1, 1:3) = [1, Xs(1), Xs(2)];
% Last node -> Xf
Nodes(end, 1:3) = [num_Nodes, Xf(1), Xf(2)];
Nodes(end, 4) = 0;
% Other nodes -> obstacles' vertices
i = 2;
row = 1;
while i < num_Nodes
    Nodes(i, 1) = i;
    Nodes(i+1, 1) = i+1;
    Nodes(i, 2:3) = B(row, 1:2);
    Nodes(i+1, 2:3) = B(row, 3:4);
    i = i + 2;
    row = row + 1;
end

%% Define Edges
Edges = inf(num_Nodes*(num_Nodes-1)/2, 4);  % Initialize Edges
row_Edges = 1;
for i = 1:num_Nodes-1
    S = [Nodes(i, 2); Nodes(i, 3)];
    for j = i+1:num_Nodes
        flag = 1;
        T = [Nodes(j, 2); Nodes(j, 3)]; 
        tempST = S' - T';
        for k = 1:N
            A = [B(k, 1); B(k, 2)]; % First vertex of a obstacle
            C = [B(k, 3); B(k, 4)]; % Second vertex of a obstacle
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
        if flag == 1
            Edges(row_Edges, 1:3) = [row_Edges, Nodes(i, 1), Nodes(j, 1)];
            row_Edges = row_Edges + 1;
        end
    end
    % end for
end
% end for
% Remove extra undesired elements of Edges
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
title('$Dijkstra\ Algorithm$', 'Interpreter', 'latex');
plot(Xs(1), Xs(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
plot(Xf(1), Xf(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
% Plot obstacles
for i = 1:N
    plot([B(i, 1), B(i, 3)], [B(i, 2), B(i, 4)], 'LineWidth', 2);
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
