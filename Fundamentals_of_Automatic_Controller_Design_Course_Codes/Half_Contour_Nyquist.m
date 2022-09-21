clc;
clear;
close all;

s = tf('s');
K = 2;
T1 = 2; 
T2 = 1;
G = K / ((s)*(1+T1*s)*(1+T2*s));

figure;
h = nyquistplot(G);
setoptions(h, 'ShowFullContour', 'off');
axis([-4, 0.5, -4, 4]);
