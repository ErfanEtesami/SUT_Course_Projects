clc;
clear;
close all;

s = tf('s');
Gp = 1 / ((s+1)^3);

Kp = 2;
Ti = 4;
Td = 4;
N = 10;
gamma = 1/N;

C1 = 1+(1/(Ti*s))+(Td*s);
C2 = (Td*s)/(1+gamma*Td*s);
C3 = 1+(1/(Ti*s))+C2;
C4 = 1+(1/(Ti*s));
C5 = 1/(Ti*s);
C6 = 1+C2;

% U1 = (C1*Kp) / (1+C1*Kp*Gp);
% U2 = (C3*Kp) / (1+C3*Kp*Gp);
% U3 = (Kp*(C4-C2)) / (1+Kp*Gp*(C4-C2));
% U4 = (Kp*(C5-C6)) / (1+Kp*Gp*(C5-C6));

Gcl1 = (C1*Kp*Gp) / (1+C1*Kp*Gp);   % PID
Gcl2 = (C3*Kp*Gp) / (1+C3*Kp*Gp);   % PID-F

Gcl3 = (C4*Kp*Gp) / (1+C1*Kp*Gp);   % PI-D
Gcl4 = (C4*Kp*Gp) / (1+C3*Kp*Gp);   % PI-DF

Gcl5 = (C5*Kp*Gp) / (1+C1*Kp*Gp);   % I-PD
Gcl6 = (C5*Kp*Gp) / (1+C3*Kp*Gp);   % I-PDF

figure;
hold on;
step(Gcl1);
step(Gcl2);
step(Gcl3);
step(Gcl4);
step(Gcl5);
step(Gcl6);
legend('PID', 'PID-F', 'PI-D', 'PI-DF', 'I-PD', 'I-PDF');
grid on;
