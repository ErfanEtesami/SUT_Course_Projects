function [K, L, T] = getFOTD(G, method)
% method == 0 -> Frequency-Response method
% method == 1 -> Transfer Function method

K = real(dcgain(G));

if (nargin==1) || (nargin == 2 && method==0)
    [Kc, PM, Wg, Wp] = margin(G);
    ikey = 0;
    L = (1.6*pi) / (3*Wg);
    T = 0.5 * Kc * K * L;
    if isfinite(Kc)
        x0 = [L; T];
        while ikey==0
            ww1 = Wg * x0(1);
            ww2 = Wg * x0(2);
            FF = [K*Kc*(cos(ww1)-ww2*sin(ww1))+1+ww2^2; sin(ww1)+ww2*cos(ww1)];
            J = [-K*Kc*Wg*sin(ww1)-K*Kc*Wg*ww2*cos(ww1), -K*Kc*Wg*sin(ww1)+2*Wg*ww2;
                 Wg*cos(ww1)-Wg*ww2*sin(ww1), Wg*cos(ww1)];
            x1 = x0 - J \ FF;
            if norm(x1-x0)<1e-8
                ikey = 1;
            else
                x0 = x1;
            end
        end
        L = x0(1);
        T = x0(2);
    end
elseif nargin==2 && method==1
%     'v' forces tfdata to return the numerator and denominator directly as 
%     row vectors rather than as cell arrays.
    [nn, dd] = tfdata(G, 'v');
    [n1, d1] = tf_derv(nn, dd);
    [n2, d2] = tf_derv(n1, d1);
    K1 = n1(end) / d1(end);
    K2 = n2(end) / d2(end);
    Tar = -K1 / K;
    T = sqrt(K2/K - Tar^2);
    L = Tar - T;
end

L = real(L);
T = real(T);

end