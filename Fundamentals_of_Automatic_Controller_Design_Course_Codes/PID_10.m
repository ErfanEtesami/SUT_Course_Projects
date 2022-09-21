clc;
clear;
close all;

s = tf('s');
Gp = 10 / ((s+1)*(s+2)*(s+3)*(s+4));

[K, L, T] = getFOTD(Gp);
[Kc, PM, Wg, Wp] = margin(Gp);
Tc = 2*pi/Wg;
kappa = dcgain(Gp)*Kc;
N = 10;

f1 = figure;
f2 = figure;

for iC = 1:3
   [Gc, Kp, Ti, Td, H] = Optimum(2, 2, [K, L, T, N, iC]); 
   Gcl = feedback(Gp, Gc*H);
   figure(f1);
   step(Gcl, 30);
   hold on;
   [Gc, Kp, Ti, Td, H] = Optimum(3, 2, [K, L, T, N, iC]); 
   Gcl = feedback(Gp, Gc*H);
   figure(f2);
   step(Gcl, 30);
   hold on;
end
figure(f1);
legend('ISE', 'ISTE', 'IST2E');
grid on;
figure(f2);
legend('ISE', 'ISTE', 'IST2E');
grid on;

figure;
hold on;
[Gc, Kp, Ti, Td, H] = Optimum(3, 1, [K, L, T, N, Kc, Tc, kappa]);
Gcl = feedback(Gc*Gp, H);
step(Gcl);
[Gc, Kp, Ti, Td, H] = Optimum(3, 2, [K, L, T, N, Kc, Tc, kappa]);
Gcl = feedback(Gp, Gc*H);
step(Gcl);
grid on;
