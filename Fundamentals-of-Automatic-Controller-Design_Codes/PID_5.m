clc;
clear;
close all;

s = tf('s');
Gp = 10 / ((s+1)*(s+2)*(s+3)*(s+4));

[K, L, T] = getFOTD(Gp);
[Kc, PM, Wg, Wp] = margin(Gp);
Tc = 2*pi/Wg;
N = 10;

[Gc1, Kp1, Ti1, Td1] = ZN(3, [K, L, T, N]);
Gcl1 = feedback(Gc1*Gp, 1);

[Gc2, Kp2, Ti2, Td2, beta2, H2] = ZN_R([K, L, T, N, Kc, Tc]);
Gcl2 = feedback(Gc2*Gp, H2);

figure;
grid on;
hold on;
step(Gcl1, 20);
step(Gcl2, 20);
legend('ZN', 'RZN');

% t_s: ZN < RZN
% overshoot : RZN < ZN