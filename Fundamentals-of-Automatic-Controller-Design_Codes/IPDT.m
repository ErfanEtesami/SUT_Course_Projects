function [Gc, Kp, Ti, Td, H] = IPDT(key, K, L, N, iC)
% design PID controller for IPDT models.
% Integrator Plus Dead (Delay) Time.

% Since there already exists an integrator in the plant model, an extra
% integrator in the controller is not required to remove a steady-state
% error to a step input, but it is needed to remove the output error caused
% by a steady disturbance at the plant input. PD controllers may also be
% used to avoid large overshoot.

Ti = [];
Td = [];
H = 1;

s = tf('s');
a = [1.03, 0.49, 1.37, 1.49, 0.59;
     0.96, 0.45, 1.36, 1.66, 0.53;
     0.90, 0.45, 1.34, 1.83, 0.49];

if key==5 % PD
    Kp = a(iC, 1) / K / L;
    Td = a(iC, 2) * L;
%     Gc = Kp * (1 + (Td*s)/(1+Td*s/N));
elseif key==3 % PID
    Kp = a(iC, 3) / K / L;
    Ti = a(iC, 4) * L;
    Td = a(iC, 5) * L;
%     Gc = Kp * (1 + 1/Ti/s + (Td*s)/(1+Td*s/N));
end

[Gc, H] = writePID(Kp, Ti, Td, N, key);

end