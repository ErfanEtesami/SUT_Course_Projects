function [Gc, Kp, Ti, Td, H] = UFOPDT(K, L, T, N, iC)
% design PID controller for Unstable FOPDT models.
% Unstable First Order Plus Dead (Delay) Time.

A = L/T;
s = tf('s');

PIDtab = [1.32, 0.92, 4.00, 0.47, 3.78, 0.84, 0.95;
          1.38, 0.90, 4.12, 0.90, 3.62, 0.85, 0.93;
          1.35, 0.95, 4.52, 1.13, 3.70, 0.86, 0.97];
      
a1 = PIDtab(iC, 1); 
b1 = PIDtab(iC, 2);  
a2 = PIDtab(iC, 3);  
b2 = PIDtab(iC, 4);  
a3 = PIDtab(iC, 5);  
b3 = PIDtab(iC, 6); 
gamma = PIDtab(iC, 7);

Kp = (a1/K) * (A^b1);
Ti = a2 * T * (A^b2);
Td = a3 * T * (1 - b3*(A^-0.02)) * (A^gamma);

[Gc, H] = writePID(Kp, Ti, Td, N, 3);

end