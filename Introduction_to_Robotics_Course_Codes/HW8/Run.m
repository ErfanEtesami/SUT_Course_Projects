clc;
clear;
close all;

% Geometry
d = 15/100;     % m
h = 65/100;     % m
l1 = 45/100;    % m
l2 = 55/100;    % m
R = 5/100;      % m

% Mass
m1 = 2; % Kg
m1h = m1*h/(h+d);   % Part h
m1d = m1*d/(h+d);   % Part d
m2 = 4; % Kg
m3 = 4; % Kg

% Electrical
Va = 48;    % Volt
Va1 = Va; Va2 = Va; Va3 = Va;
Ra = 50;    % Ohm
Kb = 7.5;   % Volt*s

% Mechanical
r = 50;     % Gear Ratio
Jm = 0.1;   % Kg.m^2
Jg = 0.05;  % Kg.m^2
Bm = 0.01;  % N.m.s
Km = 7.5;   % N.m/Amp

% Initial Positions
th1_0 = 0;    % degree
th2_0 = 0;    % degree
th3_0 = 0;    % degree

% Desired Positions
th1_d = 20; % degree
th2_d = 15; % degree
th3_d = 20; % degree

% Controller
J = Jm + Jg;
ts = 1;
a = log(0.05);
B = Bm + Km*Kb/Ra;
Kp = (J / ((ts/4.6*sqrt((a^2)/(pi^2+a^2)))^2)) * Ra / Km;
Kpm = round(Kp) - 4;
% Kpm = round(Kp) - 12;
Kd = (9.2*J/ts - B) * Ra / Km;
Kdm = round(Kd, 1) + 0.2;
% Kdm = round(Kd, 1) + 0.1;
Ki = 0.1;
Ki_bound = (Kp*Km/Ra) * (Kd*Km/Ra + B) / J;
Kp1 = Kpm; Kp2 = Kpm; Kp3 = Kpm;
Kd1 = Kdm; Kd2 = Kdm; Kd3 = Kdm;
Ki1 = Ki; Ki2 = Ki; Ki3 = Ki;
