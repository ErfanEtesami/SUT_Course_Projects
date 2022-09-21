clc;
clear;
close all;

% Part 1 - SCARA
syms theta1 theta2 d3;
Q_SCARA = [theta1; theta2; d3];

h = 30;     % cm
l1 = 30;    % cm
l2 = 25;    % cm

H_SCARA = Rot('z', theta1) * Trans('z', h) * Trans('x', l1) * ...
          Rot('z', theta2) * Trans('x', l2) * Trans('z', d3) * Rot('x', pi);

[Jv_SCARA, Jw_SCARA] = Jacob(H_SCARA, Q_SCARA);

disp("Part 1: SCARA - Jv:");
digits(4);                      % To simplify the output display
disp(simplify(vpa(Jv_SCARA)));  % To simplify the output display
disp("Part 1: SCARA - Jw:");
digits(4);                      % To simplify the output display
disp(simplify(vpa(Jw_SCARA)));  % To simplify the output display

% Part 1 - PUMA
syms theta1 theta2 theta3;
Q_PUMA = [theta1; theta2; theta3];

h = 65;     % cm
d = 15;     % cm
l1 = 45;    % cm
l2 = 55;    % cm

H_PUMA = Rot('y', -(pi/2-theta1)) * Trans('y', h) * Trans('z', d) * ...
         Rot('z', theta2) * Trans('x', l1) * Rot('z', theta3) * ...
         Trans('x', l2);

[Jv_PUMA, Jw_PUMA] = Jacob(H_PUMA, Q_PUMA);

disp("Part 1: PUMA - JV:");
digits(4);                      % To simplify the output display
disp(simplify(vpa(Jv_PUMA)));   % To simplify the output display
disp("Part 1: PUMA - Jw:");
digits(4);                      % To simplify the output display
disp(simplify(vpa(Jw_PUMA)));   % To simplify the output display

% Part 2
syms theta1 theta2 d3;
Ve = [40; 60; 15];  % cm/s

th1 = [0:0.1:360] * (pi/180);      % degree
th2 = [5:0.1:175] * (pi/180);      % degree

Q_dot = zeros(length(th1), length(th2), 3);
% To increase computation speed significantly
Q_dot_temp = Jv_SCARA \ Ve;     % = inv(Jv_SCARA) * Ve
Q_dot_fun = matlabFunction(Q_dot_temp);     

for i = 1:length(th1)
    for j = 1:length(th2)
        Q_dot(i, j, :) = Q_dot_fun(th1(i), th2(j));
    end
end

a = i - 1;
b = j - 1;
thd1 = zeros(a, b);     % theta_dot_1
thd2 = zeros(a, b);     % theta_dot_2
dtd3 = zeros(a, b);     % d_dot_3

for i = 1:a
    for j = 1:b
        thd1(i, j) = Q_dot(i, j, 1);
        thd2(i, j) = Q_dot(i, j, 2);
        dtd3(i, j) = Q_dot(i, j, 3);
    end
end

disp("Part 2:");

[max_thd1, max_thd1_loc] = max(abs(thd1(:)));
[thd1_i, thd1_j] = ind2sub(size(thd1), max_thd1_loc);
fprintf("Maximum of theta_dot_1 = %.4f (rad/s) @ theta1 = %.4f (rad), theta2 = %.4f (rad)\n",...
        max_thd1, th1(thd1_i), th2(thd1_j));
    
[max_thd2, max_thd2_loc] = max(abs(thd2(:)));
[thd2_i, thd2_j] = ind2sub(size(thd2), max_thd2_loc);
fprintf("Maximum of theta_dot_2 = %.4f (rad/s) @ theta1 = %.4f (rad), theta2 = %.4f (rad)\n",...
        max_thd2, th1(thd2_i), th2(thd2_j));
    
[max_dtd3, max_dtd3_loc] = max(abs(dtd3(:)));
fprintf("Maximum of d_dot_3 = %.4f (cm/s) @ Everywhere in the whole workspace\n",...
        max_dtd3);
    