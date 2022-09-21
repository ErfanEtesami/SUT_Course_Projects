function [Gc, Kp, Ti, Td, H] = FOIPDT(key, K, L, T, N)
% design PID controller for FOIPDT models.
% First Order lag and Integrator Plus Dead (Delay) Time.
%
% Since there already exists an integrator in the plant model, an extra
% integrator in the controller is not necessary in the controller to remove 
% the steady-state error to a set point change. Thus, a PD controller may 
% be used if there is no steady-state disturbance at the plant.

Ti = [];
Td = [];

if key==3 % PID
    a = (T/L)^0.65;
    Kp = ((1.111*T) / (K*(L^2))) / ((1+a)^2);
    Ti = 2 * L * (1+a);
    Td = Ti / 4;
elseif key==5   % PD
    Kp = 2 / (3*K*L);
    Td = T;
end

[Gc, H] = writePID(Kp, Ti, Td, N, key);
    
end