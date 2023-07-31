function y = optFun(x, G, key, r, k, dc)

ff0 = 1e10;
a = [1, x(r+1:r+k)];
b = x(1:r+1);
b(end) = a(end) * dc;
g = tf(b, a);

if key==1
    tau = x(end);
    if tau<=0
        tau = eps;
    end
    [n, d] = pade(tau, 3);
    gP = tf(n, d);   
else
    gP = 1;
end

Ge = G - g*gP;
Ge.num{1} = [0, Ge.num{1}(1:end-1)];

[y, ierr] = geth2(Ge);

if ierr==1
    y = 10 * ff0;
else
    ff0 = y;
end

end