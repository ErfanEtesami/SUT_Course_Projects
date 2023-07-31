function [Gc, Kp, Ti, Td, H] = CHR(key, typ, vars)
% design PID using the Chien-Hoones-Reswick tuning algorithm.
%
% typ == 1 -> set-point, typ == 2 -> disturbance rejection

Ti = [];
Td = [];

K = vars(1); 
L = vars(2); 
T = vars(3); 
N = vars(4); 
ovshoot = vars(5);
a = K * L / T; 

if typ==1       % set-point
    TT = T; 
elseif typ==2   % disturbance rejection
    TT = L; 
end

if ovshoot == 0 % overshoot: 0% (no overshoot)
   KK = [0.3,...            % set-point: P
         0.35, 1.2,...      % set-point: PI 
         0.6, 1, 0.5;...    % set-point: PID 
         0.3,...            % disturbance: P 
         0.6, 4,...         % disturbance: PI  
         0.95, 2.4, 0.42];  % disturbance: PID 
elseif ovshoot == 1 % overshoot: 20%
   KK = [0.7,...                % set-point: P
         0.6, 1,...             % set-point: PI 
         0.95, 1.4, 0.47;...    % set-point: PID 
         0.7,...                % disturbance: P 
         0.7, 2.3,...           % disturbance: PI 
         1.2, 2, 0.42];         % disturbance: PID 
end

switch key 
    case 1  % P 
        Kp = KK(typ, 1) / a; 
    case 2  % PI 
        Kp = KK(typ, 2)/ a; 
        Ti = KK(typ, 3) * TT; 
    case {3, 4} % 3:PID, 4:PI-D
        Kp = KK(typ, 4) / a; 
        Ti = KK(typ, 5) * TT; 
        Td = KK(typ, 6) * L;
end

[Gc, H] = writePID(Kp, Ti, Td, N, key);

end