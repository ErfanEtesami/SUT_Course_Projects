function [Gc, H] = writePID(Kp, Ti, Td, N, key)

s = tf('s');

switch key
    case 1  % P
        Gc = Kp;
        H = 1;
    case 2  % PI
        Gc = Kp * (1 + 1/Ti/s);
        H = 1;
    case 3  % PID
        Gc = Kp * (1 + (1/Ti/s) + (Td*s)/(1+Td*s/N));
        H = 1;
    case 4  % PI-D
        Gc = Kp * (1 + 1/Ti/s);
        Gd = (Td*s) / (1+Td*s/N);
        H = 1 + Gd / Gc;
    case 5  % PD
        Gc = Kp * (1 + (Td*s)/(1+Td*s/N));
        H = 1;
end

end