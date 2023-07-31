function [Gc, Kp, Ti, Td, H] = CC(key, typ, vars)
% design PID controller using the Cohen-Coon algorithm.
% 
% typ == 1 -> CC, typ == 2 -> CC-Revisited
Ti = [];
Td = [];

K = vars(1); 
L = vars(2); 
T = vars(3);
N = vars(4);
a = K * L / T; 

if typ==1   %% CC  
    switch key
        case 1  % P
            Kp = (1/a) * (1 + L/3/T);
        case 2  % PI
            Kp = (1/a) * (0.9 + L/12/T);
            Ti = ((30+3*L/T)/(9+20*L/T)) * L;
        case {3, 4}  % 3:PID, 4:PI-D
            Kp = (1/a) * (4/3 + L/4/T);
            Ti = ((32+6*L/T)/(13+8*L/T)) * L;
            Td = (4/(11+2*L/T)) * L;
    end
elseif typ==2   % CC-Revisited
    tau = L / (L+T); 
    switch key
        case 1  % P
            Kp = (1/a) * (1 + (0.35*tau)/(1-tau));
        case 2  % PI
            Kp = (0.9/a) * (1 + 0.92*tau/(1-tau));
            Ti = ((3.3-3*tau)/(1+1.2*tau)) * L;
        case {3, 4}  % 3:PID, 4:PI-D
            Kp = (1.35/a) * (1 + 0.18*tau/(1-tau));
            Ti = ((2.5-2*tau)/(1-0.39*tau)) * L;
            Td = ((0.37*(1-tau))/(1-0.81*tau)) * L;
        case 5  % PD
            Kp = (1.24/a) * (1+0.13*tau/(1-tau));
            Td = ((0.27-0.36*tau)/(1-0.87*tau)) * L;
    end
end

[Gc, H] = writePID(Kp, Ti, Td, N, key);

end