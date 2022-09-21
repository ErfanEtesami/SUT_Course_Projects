clc;
clear;
close all;

s = tf('s');
G1 = 1 / ((s+1)^4);
Gp = G1 / s;
[K1, L1, T1] = getFOTD(G1);
Gr = optApp(G1, 0, 1, 1);
% Gr = ([0, z] / [1, p]) * exp(-L*s) == Gr = (z / p) * (1 / [1/p , 1]) * exp(-L*s)
K2 = Gr.num{1}(2) / Gr.den{1}(2);   % K = z / p
L2 = Gr.ioDelay;
T2 = 1 / Gr.den{1}(2);  % T = 1 / p
N  = 10;

[Gc1, Kp1, Ti1, Td1, H1] = FOIPDT(5, K1, L1, T1, N);    % PD - getFOTD
Gcl1 = feedback(Gp*Gc1, H1);
[Gc2, Kp2, Ti2, Td2, H2] = FOIPDT(5, K2, L2, T2, N);    % PD - optApp
Gcl2 = feedback(Gp*Gc2, H2);
[Gc3, Kp3, Ti3, Td3, H3] = FOIPDT(3, K1, L1, T1, N);    % PID - getFOTD
Gcl3 = feedback(Gp*Gc3, H3);
[Gc4, Kp4, Ti4, Td4, H4] = FOIPDT(3, K2, L2, T2, N);    % PID - optApp
Gcl4 = feedback(Gp*Gc4, H4);

figure;
hold on;
grid on;
% step(Gcl1, 120);
step(Gcl2, 120);
% step(Gcl3, 120);
step(Gcl4, 120);
% legend('PD - getFOTD', 'PD - optApp', 'PID - getFOTD', 'PID - optApp');
legend('PD - optApp', 'PID - optApp');

% It can be seen that the PD controller is significantly better than the
% PID controller. This is because the 180\degree lag given by two
% integrators makes good control more difficult.

% If the main system is unstable, getFOTD do not work correctly, but
% optApp(G1, 0, 1, 1) could approzimate the model with an unstable FOPDT
% model.