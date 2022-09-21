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

%% Simulink
% stepinfo(ScopeData(:, 2), ScopeData(:, 1), L/2)
% figure;
% plot(ScopeData(:, 1), ScopeData(:, 2));
% grid on;
