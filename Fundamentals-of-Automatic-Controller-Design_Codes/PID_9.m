clc;
clear;
close all;

s = tf('s');
Gp = 10 / ((s+1)*(s+2)*(s+3)*(s+4));

N = 10;

[K1, L1, T1] = getFOTD(Gp);
[Gc1, Kp1, Ti1, Td1, H1] = ZN(3, [K1, L1, T1, N]);
Gcl1 = feedback(Gc1*Gp, H1);

[K2, L2, T2] = getFOTD(Gp, 1);
[Gc2, Kp2, Ti2, Td2, H2] = ZN(3, [K2, L2, T2, N]);
Gcl2 = feedback(Gc2*Gp, H2);

figure;
grid on;
step(Gcl1, Gcl2);
legend('Frequency Response', 'Transfer Function');

figure;
hold on;
step(Gp, K1*exp(-L1*s)/(Ti1*s+1), K2*exp(-L2*s)/(Ti2*s+1));
legend('Original System', 'Frequency Response', 'Transfer Function');