clc;
clear;
close all;

s = tf('s');
G = 2 / ((s+1)*(s+2));
K = ((s+1)*(s+2)) / (2*s*(s+2.5));

% lambda = 0.1;
% Kc = 5;
% Td = 0;
% Ti = 1;
% b = 1;
% c = 0;
% N0 = inf;
% N = 0.7;
% Tt0 = inf;
% gamma = [0, 0.5, 1, 2];
% Tt = 1 ./ gamma;

% gamma = 1 is the best choice.