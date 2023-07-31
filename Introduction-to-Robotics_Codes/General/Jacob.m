function [Jv, Jw] = Jacob(H, Q)

n = length(Q);

% Jv
O0_Oe = H(1:3, 4);

Jv = sym(zeros(3, n));
for i = 1:3
    for j = 1:n
       Jv(i, j) = diff(O0_Oe(i), Q(j)); 
    end
end

% Jw
R0_e = H(1:3, 1:3);

Jw = sym(zeros(3, n));
for i = 1:3
    if i == 1
        c1 = 3; c2 = 2;
    elseif i == 2
        c1 = 1; c2 = 3;
    else
        c1 = 2; c2 = 1;
    end
    
    for k = 1:n
        for j = 1:3
            Jw(i, k) = Jw(i, k) + diff(R0_e(c1, j), Q(k)) * R0_e(c2, j);
        end
    end
end
    
end