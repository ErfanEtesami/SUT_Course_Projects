function [Gc, Kp, Ti, Td, H] = AH(key, typ, vars)
% design PID controller using the Astrom-Hagglund algorithm.
% 
% typ == 1 -> AH (FOTD), typ == 2 -> AH (FR: Frequency-Response)

Ti = [];
Td = [];

if typ==1   % AH (FOTD)
    K = vars(1);
    L = vars(2);
    T = vars(3);
    N = vars(4);
    switch key
        case 2 % PI
            Kp = 0.15/K + (0.35-(L*T)/((L+T)^2)) * (T/K/L);
            Ti = 0.35*L + (13*L*(T^2))/((T^2)+12*L*T+7*(L^2));
        case {3, 4} % 3:PID, 4:PI-D
            Kp = (0.2+0.45*T/L)/K;
            Ti = (0.4*L+0.8*T) * (L/(L+0.1*T));
            Td = 0.5*L*T/(0.3*L+T);
    end
elseif typ==2   % AH (FR: Frequency-Response)
    K = vars(1);
    Ku = vars(2);
    Tu = vars(3);
    N = vars(4);
    kappa = 1 / (Ku * K); 
    switch key
        case 2 % PI
            Kp = 0.16*Ku;
            Ti = Tu / (1+4.5*kappa);
        case {3, 4} % 3:PID, 4:PI-D
            Kp = (0.3-0.1*(kappa^4))*Ku;
            Ti = (0.6*Tu) / (1+2*kappa);
            Td = 0.15*Tu*(1-kappa) / (1-0.95*kappa);
    end
end

[Gc, H] = writePID(Kp, Ti, Td, N, key);

end