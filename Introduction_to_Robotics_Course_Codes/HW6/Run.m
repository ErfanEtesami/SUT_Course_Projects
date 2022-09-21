clc;
clear;
close all;

%% General
Xs = [4; 9];
Xf = [28; 19];

Rho0 = 2;   % distance of influence
Alpha = 1;  
Eta = 1;

%% Part a
% obstacles
B1 = [6, 4, 10, 11, Rho0, Alpha];
B2 = [8, 17, 16, 15, Rho0, Alpha];
B3 = [16, 9, 22, 17, Rho0, Alpha];
B = [B1; B2; B3];

% call Path_generator function without random walk -> flag = 0
Path_a = Path_generator(Xs, Xf, Eta, B, 0);

% show path and obstacles
figure;
hold on;
grid on;
box on;
axis([0, Xf(1)+2, 0, Xf(2)+1]);
axis equal;
xlabel('$X$', 'Interpreter', 'latex');
ylabel('$Y$', 'Interpreter', 'latex');
title('$Part\ a$', 'Interpreter', 'latex');
plot(Xs(1), Xs(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
text(Xs(1)-0.5, Xs(2)-0.7, '$X_s$', 'Interpreter', 'latex', 'Color', 'black');
plot(Xf(1), Xf(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
text(Xf(1)-0.5, Xf(2)-0.7, '$X_f$', 'Interpreter', 'latex', 'Color', 'black');
for i = 1:size(B, 1)
    plot([B(i, 1), B(i, 3)], [B(i, 2), B(i, 4)], 'LineWidth', 2);
    text(mean([B(i, 1), B(i, 3)])-0.3, mean([B(i, 2), B(i, 4)])-0.9, ['$B_', num2str(i), '$'],... 
         'Interpreter', 'latex', 'Color', 'black');
end
plot(Path_a(:, 1), Path_a(:, 2), 'k-');
% print(gcf, 'G:\University\Robotics\HWs\HW6\6','-dpng','-r500');

%% Part b
% obstacles
B4 = [26, 10, 26, 22, Rho0, Alpha];
B = [B; B4];

% call Path_generator function without random walk -> flag = 0
Path_b = Path_generator(Xs, Xf, Eta, B, 0);

% show path and obstacles
figure;
hold on;
grid on;
box on;
axis([0, Xf(1)+2, 0, B(4, 4)+1]);
axis equal;
xlabel('$X$', 'Interpreter', 'latex');
ylabel('$Y$', 'Interpreter', 'latex');
title('$Part\ b$', 'Interpreter', 'latex');
plot(Xs(1), Xs(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
text(Xs(1)-0.5, Xs(2)-0.7, '$X_s$', 'Interpreter', 'latex', 'Color', 'black');
plot(Xf(1), Xf(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
text(Xf(1)-0.5, Xf(2)-0.7, '$X_f$', 'Interpreter', 'latex', 'Color', 'black');
for i = 1:size(B, 1)
    plot([B(i, 1), B(i, 3)], [B(i, 2), B(i, 4)], 'LineWidth', 2);
    text(mean([B(i, 1), B(i, 3)])+0.1, mean([B(i, 2), B(i, 4)])-0.75, ['$B_', num2str(i), '$'],... 
         'Interpreter', 'latex', 'Color', 'black');
end
plot(Path_b(:, 1), Path_b(:, 2), 'k-');
plot(Path_b(end, 1), Path_b(end, 2), '.', 'MarkerSize', 15);
% print(gcf, 'G:\University\Robotics\HWs\HW6\11','-dpng','-r500');

% zoom on local minima
figure;
hold on;
grid on;
box on;
zoom = 0.15;
axis([Path_b(end, 1)-zoom, Path_b(end, 1)+zoom, Path_b(end, 2)-zoom, Path_b(end, 2)+zoom]);
xlabel('$X$', 'Interpreter', 'latex');
ylabel('$Y$', 'Interpreter', 'latex');
title('$Part\ b$', 'Interpreter', 'latex');
plot(Xs(1), Xs(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
text(Xs(1)-0.5, Xs(2)-0.7, '$X_s$', 'Interpreter', 'latex', 'Color', 'black');
plot(Xf(1), Xf(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
text(Xf(1)-0.5, Xf(2)-0.7, '$X_f$', 'Interpreter', 'latex', 'Color', 'black');
for i = 1:size(B, 1)
    plot([B(i, 1), B(i, 3)], [B(i, 2), B(i, 4)], 'LineWidth', 2);
    text(mean([B(i, 1), B(i, 3)])+0.1, mean([B(i, 2), B(i, 4)])-0.75, ['$B_', num2str(i), '$'],... 
         'Interpreter', 'latex', 'Color', 'black');
end
plot(Path_b(:, 1), Path_b(:, 2), 'k--');
plot(Path_b(end, 1), Path_b(end, 2), '.', 'MarkerSize', 20);
% print(gcf, 'G:\University\Robotics\HWs\HW6\12','-dpng','-r500');

%% Part c
B = B(1:end-1, :);
B4 = [26, 10, 26, 22, Rho0, Alpha];   % 1
% B4 = [26, 19, 26, 24, Rho0, Alpha];   % 2
% B4 = [26, 18, 26, 24, Rho0, Alpha];   % 3
% B4 = [5.5, 5, 5.5, 12, Rho0, Alpha];  % 4
% B4 = [20, 16, 20, 20, Rho0, Alpha];  % 5
% B4 = [25, 10, 25, 22, Rho0, Alpha];  % 6
B = [B; B4];

% call Path_generator function with random walk -> flag = 1
Path_c = Path_generator(Xs, Xf, Eta, B, 1);

% show path and obstacles
figure;
hold on;
grid on;
box on;
axis([0, Xf(1)+2, 0, max(Path_c(:, 2))+1]);
axis equal;
xlabel('$X$', 'Interpreter', 'latex');
ylabel('$Y$', 'Interpreter', 'latex');
title('$Part\ c$', 'Interpreter', 'latex');
plot(Xs(1), Xs(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
text(Xs(1)-0.5, Xs(2)-0.7, '$X_s$', 'Interpreter', 'latex', 'Color', 'black');
plot(Xf(1), Xf(2), '.', 'MarkerSize', 15, 'Color', [0.8500 0.3250 0.0980]);
text(Xf(1)-0.5, Xf(2)-0.7, '$X_f$', 'Interpreter', 'latex', 'Color', 'black');
for i = 1:size(B, 1)
    plot([B(i, 1), B(i, 3)], [B(i, 2), B(i, 4)], 'LineWidth', 2);
    text(mean([B(i, 1), B(i, 3)])+0.1, mean([B(i, 2), B(i, 4)])-0.75, ['$B_', num2str(i), '$'],...
         'Interpreter', 'latex', 'Color', 'black');
end
plot(Path_c(:, 1), Path_c(:, 2), 'k-');
% print(gcf, 'G:\University\Robotics\HWs\HW6\14','-dpng','-r500');