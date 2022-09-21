clc;
clear;
close all;

s = tf('s');
Gp = 10 / ((s+1)*(s+2)*(s+3)*(s+4));

[K, L, T] = getFOTD(Gp);
N = 10;

[Gc1, Kp1, Ti1, Td1] = ZN(3, [K, L, T, N]);
Gcl1 = feedback(Gc1*Gp, 1);

[Gc2, Kp2, Ti2, Td2] = CHR(3, 1, [K, L, T, N, 0]);
Gcl2 = feedback(Gc2*Gp, 1);

[Gc3, Kp3, Ti3, Td3] = CHR(3, 1, [K, L, T, N, 1]);
Gcl3 = feedback(Gc3*Gp, 1);

[Gc4, Kp4, Ti4, Td4] = CHR(3, 2, [K, L, T, N, 0]);
Gcl4 = feedback(Gc4*Gp, 1);

figure;
grid on;
hold on;
step(Gcl1, 10);
step(Gcl2, 10);
step(Gcl3, 10);
step(Gcl4, 10);
legend('ZN', 'CHR0', 'CHR20', 'D-CHR0');

Gcl1 = feedback(Gp, Gc1);
Gcl2 = feedback(Gp, Gc2);
Gcl3 = feedback(Gp, Gc3);
Gcl4 = feedback(Gp, Gc4);

figure;
grid on;
hold on;
step(Gcl1, 30);
step(Gcl2, 30);
step(Gcl3, 30);
step(Gcl4, 30);
legend('ZN', 'CHR0', 'CHR20', 'D-CHR0');
