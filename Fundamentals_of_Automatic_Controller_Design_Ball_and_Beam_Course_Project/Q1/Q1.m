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
% zpk(Gp);

%% IMC
% alpha = 1;
% [Ns, Xs, Ms, Ys] = Euclid(Gp, alpha);
% zpk(Ns*10^-15)
% zpk(Xs*10^15)
% zpk(Ms*10^-15)
% zpk(Ys*10^15)
% Q = 0;
% K = (Xs+Ms*Q) / (Ys-Ns*Q);
% K = reduce(K, 3);
% zpk(K)

%% Design 2
K = -2941.2*(s^2 + 0.4*s + 0.0425)/((s+25)^2);
Gps = K*Gp;
% zpk(Gps)

%% Design 3
C = 85*(s+2.4)/(s+60);
% pidstd(C)

%% Simulink
% stepinfo(ScopeData(:, 2), ScopeData(:, 1), L/2)
% figure;
% plot(ScopeData(:, 1), ScopeData(:, 2));
% grid on;

%% Q6
% Margins
[GM, PM, WP, WG] = margin(C*Gps*VR);
GM = 20*log10(GM);
% Sensitivities
loops = loopsens(Gps*VR, C); 
S = loops.So;
T = loops.To;
% figure;
% opt = bodeoptions('cstprefs');
% opt.PhaseVisible = 'off';
% bodeplot(S, T, opt);
% grid on;
% legend('S', 'T', 'Location', 'southwest');
