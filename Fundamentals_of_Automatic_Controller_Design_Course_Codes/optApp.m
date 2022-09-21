function Gr = optApp(G, r, k, key, G0)
% Optimization-based model reduction by minimizing e(t) via the ISE
% criterion.

% r and k are the expected orders of the numerator and denominator,
% respectively. 
% key indicates whether a delay term is expected in the reduced model.
% G0 is the optional initial reduced-order model.

Gs = tf(G);
num = Gs.num{1};
den = Gs.den{1};
Td = totaldelay(Gs);
Gs.ioDelay = 0;
Gs.InputDelay = 0;
Gs.OutputDelay = 0;

if nargin<5
    n0 = [1, 1];
    for i = 1:k-2
        n0 = conv(n0, [1, 1]);
    end
    G0 = tf(n0, conv([1, 1], n0));
end

beta = G0.num{1}(k+1-r:k+1);
alpha = G0.den{1};
Tau = 1.5 * Td;

x = [beta(1:r), alpha(2:k+1)];

if abs(Tau)<1e-5
    Tau = 0.5;
end

dc = dcgain(Gs);

if key==1
    x = [x, Tau];
end

y = optFun(x, Gs, key, r, k, dc);
x = fminsearch('optFun', x, [], Gs, key, r, k, dc);

alpha = [1, x(r+1:r+k)];
beta = x(1:r+1);

if key==0
    Td = 0;
end

beta(r+1) = alpha(end) * dc;

if key==1
    Tau = x(end) + Td;
else
    Tau = 0;
end

Gr = tf(beta, alpha, 'ioDelay', Tau);

end