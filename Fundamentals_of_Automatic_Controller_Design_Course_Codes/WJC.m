function [Gc, Kp, Ti, Td, H] = WJC(vars)
% design PID controller using the Wang-Juang-Chan algorithm.
% Based on the optimum ITAE criterion.

K = vars(1); 
L = vars(2); 
T = vars(3); 
N = vars(4);

Kp = (0.7303+0.5307*T/L) * (T+0.5*L) / (K*(T+L));
Ti = T + 0.5 * L;
Td = (0.5*L*T) / (T+0.5*L);

[Gc, H] = writePID(Kp, Ti, Td, N, 3);

end