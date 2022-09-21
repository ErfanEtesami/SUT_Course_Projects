function Theta = InversePos_RRR(X, Y, Z)

Theta = zeros(3, 1);

P0_0 = [X; Y; Z; 1];

h = 65;     % cm
d = 15;     % cm
l1 = 45;    % cm
l2 = 55;    % cm

syms theta1

% theta1
if sqrt(X^2 + Z^2) >= d
    eqn1 = Z*sind(theta1) - d == X*cosd(theta1);
    sol_theta1 = solve(eqn1, theta1, 'Real', true);
    Theta(1) = sol_theta1(1);
end
P1_1 = Rot('y', 90-Theta(1)) * Trans('y', -h) * Trans('z', -d) * P0_0; 

if sqrt(P1_1(1)^2 + P1_1(2)^2) <= l1+l2 && Theta(1) ~= 0
    % theta3
    temp3 = ((P1_1(1)^2) + (P1_1(2)^2) - (l1^2) - (l2^2)) / (2*l1*l2);
    sol_theta3 = acosd(temp3);
    Theta(3) = sol_theta3(1);

    % theta2
    beta = atan2d(P1_1(2), P1_1(1));
    alpha = atan2d(l2*sind(Theta(3)), l1+l2*cosd(Theta(3)));
    Theta(2) = beta - alpha;
end

end