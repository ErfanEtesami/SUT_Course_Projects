clc;
clear;
close all;

num = [68.6131, 80.3787, 67.0870, 29.9339, 8.8818, 1];
den = [0.0462, 3.5338, 16.5609, 28.4472, 21.7611, 7.6194, 1];
G = tf(num, den);
Gr = zpk(optApp(G, 2, 3, 0));

figure;
grid on;
step(G, Gr, 10);
legend('G', 'Gr');

s = tf('s');
G = 432 / ((5*s+1)*(2*s+1)*(0.7*s+1)*(s+1)*(0.4*s+1));
Gr = zpk(optApp(G, 0, 2, 1));

figure;
grid on;
step(G, Gr, 30);
legend('G', 'Gr');