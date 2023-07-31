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

%% Controllers
Kp1 = 29.0384; Ki1 = -0.1372; Kd1 = 6.7898; T1 = 0.01;  % ITAE
C1 = Kp1 + Ki1/s + (Kd1*s)/(T1*s+1);                    % ITAE
% zpk(C1)
% pidstd(C1)
% Gcl1 = feedback(C1*Gps, 1);
% figure;
% step(Gcl1);
% grid on;
% legend('ITAE');

Kp2 = 50.2017; Ki2 = -0.0024; Kd2 = 10.8185; T2 = 0.01;  % ISE
C2 = Kp2 + Ki2/s + (Kd2*s)/(T2*s+1);                     % ISE
% zpk(C2)
% pidstd(C2)

Kp3 = 44.1321; Ki3 = -0.0776; Kd3 = 9.7242; T3 = 0.01;  % ITSE
C3 = Kp3 + Ki3/s + (Kd3*s)/(T3*s+1);                    % ITSE
% zpk(C3)
% pidstd(C3)

Kp4 = 35.0643; Ki4 = -0.0941; Kd4 = 7.8264; T4 = 0.01;  % IT2SE
C4 = Kp4 + Ki4/s + (Kd4*s)/(T4*s+1);                    % IT2SE
% zpk(C4)
% pidstd(C4)

%% Simulink
% stepinfo(stepITAE(:, 2), stepITAE(:, 1), L/2)
% figure;
% plot(stepITAE(:, 1), stepITAE(:, 2));
% grid on;

% stepinfo(stepISE(:, 2), stepISE(:, 1), L/2)
% figure;
% plot(stepISE(:, 1), stepISE(:, 2));
% grid on;

% stepinfo(stepITSE(:, 2), stepITSE(:, 1), L/2)
% figure;
% plot(stepITSE(:, 1), stepITSE(:, 2));
% grid on;

% stepinfo(stepIT2SE(:, 2), stepIT2SE(:, 1), L/2)
% figure;
% plot(stepIT2SE(:, 1), stepIT2SE(:, 2));
% grid on;

%% Q6
% Margins
[GM, PM, WP, WG] = margin(C1*Gps);
GM = 20*log10(GM);
% Sensitivities
loops = loopsens(Gps, C1); 
S = loops.So;
T = loops.To;
% figure;
% opt = bodeoptions('cstprefs');
% opt.PhaseVisible = 'off';
% bodeplot(S, T, opt);
% grid on;
% legend('S', 'T', 'Location', 'southwest');
