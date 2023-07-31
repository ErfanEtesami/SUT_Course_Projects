clc;
clear;
close all;

h = 50;     % cm
l1 = 45;    % cm
l2 = 40;    % cm
th1 = [0, 189, 340, -90, 100, 25];  % degree
th2 = [0, 10, -45, -90, -100, 270]; % degree
d3 = [13, 25, -10, 30, 50, 0];      % cm

% column 1 (a)
H_3_0_a = Rot('z', th1(1)) * Trans('z', h) * Trans('x', l1) *...
          Rot('z', th2(1)) * Trans('x', l2) *...
          Trans('z',-d3(1)) * Rot('x', 180);  
xyz_a = H_3_0_a(1:3, 4);
fprintf("xyz_a: x = %.2f, y = %.2f, z = %.2f \n", xyz_a(1), xyz_a(2), xyz_a(3));

% column 2 (b)
H_3_0_b = Rot('z', th1(2)) * Trans('z', h) * Trans('x', l1) *...
          Rot('z', th2(2)) * Trans('x', l2) *...
          Trans('z',-d3(2)) * Rot('x', 180);  
xyz_b = H_3_0_b(1:3, 4);
fprintf("xyz_b: x = %.2f, y = %.2f, z = %.2f \n", xyz_b(1), xyz_b(2), xyz_b(3));

% column 3 (c)
H_3_0_c = Rot('z', th1(3)) * Trans('z', h) * Trans('x', l1) *...
          Rot('z', th2(3)) * Trans('x', l2) *...
          Trans('z',-d3(3)) * Rot('x', 180);  
xyz_c = H_3_0_c(1:3, 4);
fprintf("xyz_c: x = %.2f, y = %.2f, z = %.2f \n", xyz_c(1), xyz_c(2), xyz_c(3));

% column 4 (d)
H_3_0_d = Rot('z', th1(4)) * Trans('z', h) * Trans('x', l1) *...
          Rot('z', th2(4)) * Trans('x', l2) *...
          Trans('z',-d3(4)) * Rot('x', 180);  
xyz_d = H_3_0_d(1:3, 4);
fprintf("xyz_d: x = %.2f, y = %.2f, z = %.2f \n", xyz_d(1), xyz_d(2), xyz_d(3));

% column 5 (e)
H_3_0_e = Rot('z', th1(5)) * Trans('z', h) * Trans('x', l1) *...
          Rot('z', th2(5)) * Trans('x', l2) *...
          Trans('z',-d3(5)) * Rot('x', 180);  
xyz_e = H_3_0_e(1:3, 4);
fprintf("xyz_e: x = %.2f, y = %.2f, z = %.2f \n", xyz_e(1), xyz_e(2), xyz_e(3));

% column 6 (f)
H_3_0_f = Rot('z', th1(6)) * Trans('z', h) * Trans('x', l1) *...
          Rot('z', th2(6)) * Trans('x', l2) *...
          Trans('z',-d3(6)) * Rot('x', 180);  
xyz_f = H_3_0_f(1:3, 4);
fprintf("xyz_f: x = %.2f, y = %.2f, z = %.2f \n", xyz_f(1), xyz_f(2), xyz_f(3));

% simulink
theta1 = th1(2);
theta2 = th2(2);
dist3 = d3(2);
