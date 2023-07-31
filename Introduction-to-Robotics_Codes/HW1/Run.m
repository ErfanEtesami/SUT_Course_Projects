clc;
clear;
close all;

% part a
th1 = 30;   % degree
th2 = 10;   % degree
l_a = 30;   % cm
d = 18;     % cm

H_0_e_a = Rot('z', th1) * Trans('x', l_a) * Rot('z', th2) * Trans('x', d);

disp('Part a');
disp(H_0_e_a);

% part b
th = 40;    % degree
u = 40;     % cm
v = 50;     % cm
w = 10;     % cm
m = 10;     % cm
l_b = 12;   % cm
h = 5;      % cm

H_0_e_b = Trans('x', u) * Trans('y', v) * Rot('y', th) * Trans('x', -w-l_b) * Trans('y', -m);

disp('Part b');
disp(H_0_e_b);
