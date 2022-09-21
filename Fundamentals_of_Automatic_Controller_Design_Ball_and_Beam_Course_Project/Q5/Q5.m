%% General
clc;
clear;
close all;
% s
s = tf('s');
% Parameters
L = 1;      % m
d = 5/100;  % m
a = 2/100;  % m
m = 1;      % Kg
c = 0.5;    % Kg.m/s
g = 9.8;    % m/(s^2)
nG = 5;
nSat = 10;
nVR = 1/2;
% Transfer Functions
VR = 0*s + nVR;
P = (g*d) / ((7/5*L*s^2)+(c/m*L*s));
G = (0.0274) / ((0.003228*s^2)+(0.003508*s));
Gp = G*(-1/nG)*P;
K = -2941.2*(s^2 + 0.4*s + 0.0425)/((s+25)^2);
Gps = K*Gp*VR;

%% Controller
% C
% zpk(C)
Kp = 4.88; Ki = 1.63; Kd = 3.35; Tf = 0.0391; b = 0.78; c = 0.31;
% C1o = b*Kp + Ki/s + c*Kd*s/(Tf*s+1);  % Cr
% C2o = -(Kp + Ki/s + Kd*s/(Tf*s+1));   % Cy
C = Kp + Ki/s + Kd*s/(Tf*s+1);
X = ((b*Kp*Tf+c*Kd)*(s^2)+(b*Kp+Ki*Tf)*s+Ki) / ((Kp*Tf+Kd)*(s^2)+(Kp+Ki*Tf)*s+Ki);  % Pre-filter

%% Simulink
% stepinfo(ScopeData(:, 2), ScopeData(:, 1), L/2)
% figure;
% plot(ScopeData(:, 1), ScopeData(:, 2));
% grid on;

%% Q6
% Margins
[GM, PM, WP, WG] = margin(C*Gps);
GM = 20*log10(GM);
% Sensitivities
loops = loopsens(Gps, C); 
S = loops.So;
T = loops.To;
% figure;
% opt = bodeoptions('cstprefs');
% opt.PhaseVisible = 'off';
% bodeplot(S, T, opt);
% grid on;
% legend('S', 'T', 'Location', 'southwest');
