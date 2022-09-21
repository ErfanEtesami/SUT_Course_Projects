clc;
clear;
close all;

s = tf('s');

Gp = 4/((2*s+1)*(3*s+1)*(6*s+1));

[K1, L1, T1] = getFOTD(Gp, 0);  % FR (Frequency Response)
[K2, L2, T2] = getFOTD(Gp, 1);  % TF (Transfer Function)
Gr = optApp(Gp, 0, 1, 1);
% Gr=([0, z]/[1, p])*exp(-L*s) == Gr=(z/p)*(1/[1/p, 1])*exp(-L*s)
K3 = Gr.num{1}(2) / Gr.den{1}(2);   % K = z / p
L3 = Gr.ioDelay;
T3 = 1 / Gr.den{1}(2);  % T = 1 / p

tvect = 0:0.0001:20;    % provide any time limits you want; 
                       % the smaller time increment the higher "accuracy"
[val, t] = step(Gp, tvect);
idx_Tc = find(val>=0.63*max(val), 1, 'first');
Tc = t(idx_Tc);        % Tc which you are looking for
val_Tc = val(idx_Tc);  % value at Tc

figure;
step(Gp);
grid on;
