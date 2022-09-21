function [Gc, Kp, Ti, Td, beta, H] = ZN_R(vars)
% design PID controller using the Refined Ziegler-Nichols algorithm.
%
% beta < 1 in general
% beta = 0 I-PD
% beta = 1 PI-D
% 0 < beta < 1 -> combination of I-PD and PI-D

K = vars(1); 
L = vars(2); 
T = vars(3); 
N = vars(4); 
Kc = vars(5);
Tc = vars(6); 
a = K * L / T;
tau = L / T;
Kp = 1.2 / a;   % Original ZN PID parameter
Ti = 2 * L;     % Original ZN PID parameter
Td = L / 2;     % Original ZN PID parameter 
kappa = Kc * K; 

if (kappa>2.25 && kappa<15) || (tau>0.16 && tau<0.57)
    beta = (15-kappa)/(15+kappa);   % To ensure that overshoot is less than 10%
%     beta = 36/(27+5*kappa);       % To ensure that overshoot is less than 20%
elseif (kappa>1.5 && kappa<2.25) || (tau>0.57 && tau<0.96)
    mu = (4/9) * kappa; 
    beta = (8/17) * (mu-1); 
    Ti = 0.5 * mu * Tc;
elseif (kappa>1.2 && kappa<1.5)
    % To ensure that overshoot is less than 10%
    Kp = (5/6) * (12+kappa)/(15+14*kappa);  
    Ti = 0.2 * (4*kappa/15+1); 
    beta = 1;
end

Gc = tf(Kp*[beta*Ti, 1], [Ti, 0]); 
nH = [Ti*Td*beta*(N+2-beta)/N, Ti+Td/N, 1];
dH = conv([Ti*beta, 1], [Td/N, 1]); 
H = tf(nH, dH);

end