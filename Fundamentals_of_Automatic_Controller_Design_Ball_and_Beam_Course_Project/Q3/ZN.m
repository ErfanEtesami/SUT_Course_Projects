function [Gc, Kp, Ti, Td, H] = ZN(key, vars)
% design PID controller using the Ziegler-Nichols algorithm.

Ti = [];
Td = [];

if length(vars)==4    % FOTD (similar to Ogata: Table 8-1)
    K = vars(1);
    L = vars(2);
    T = vars(3);
    N = vars(4);
    a = K * L / T;
    if key==1 % P
        Kp = 1 / a;
    elseif key==2 % PI
        Kp = 0.9 / a;
        Ti = 3.33 * L;  % Ti = L / 0.3; 
    elseif key==3 || key==4 % 3:PID, 4:PI-D
        Kp = 1.2 / a;
        Ti = 2 * L;
        Td = L / 2; % Ti = 0.5 * L;
    end 
elseif length(vars)==3    % FR: Frequency-Response (similar to Ogata: Table 8-2)
    Kc = vars(1);
    Tc = vars(2);
    N = vars(3);
    if key==1 % P
        Kp = 0.5 * Kc;
    elseif key==2 % PI
        Kp = 0.4 * Kc;      % Kp = 0.45 * K;
        Ti = 0.8 * Tc;      % Ti = Tc / 1.2;
    elseif key==3 || key==4 % 3:PID, 4:PI-D
        Kp = 0.6 * Kc;
        Ti = 0.5 * Tc;
        Td = 0.12 * Tc; % Td = 0.125 * Tc;
    end 
elseif length(vars)==5    % Modified ZN Control Tuning
    Kc = vars(1);
    Tc = vars(2);
    rb = vars(3);
    pb_degree = vars(4);
    N = vars(5);
    pb = pb_degree * pi / 180;
    Kp = Kc * rb * cos(pb);
    
    if key==2 % PI
        Ti = -Tc / (2*pi*tan(pb));
    elseif key==3 || key==4 % 3:PID, 4:PI-D
        Ti = (Tc/pi) * (1+sin(pb)) / cos(pb);
        Td = Ti / 4;
    end
end

[Gc, H] = writePID(Kp, Ti, Td, N, key);

end