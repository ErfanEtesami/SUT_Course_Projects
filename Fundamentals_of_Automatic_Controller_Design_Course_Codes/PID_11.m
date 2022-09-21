clc;
clear;
close all;

s = tf('s');
Gp = 1 / ((s+1)^3);

Ti = 1;
Td = 1;
N = 10;

Kp = [0.4, 1, 2];

% All plots in one figure
figure;
hold on;
Legend = cell(length(Kp), 2); 
for i = 1:length(Kp)
    % Scheme 1
    Gc1 = Kp(i) * (1 + 1/Ti/s);  
    Gd = (Td*s) / (1+Td*s/N);
    H1 = 1 + Gd / Gc1;
    step(feedback(Gc1*Gp, H1));
    % Scheme 2
    Gc2 = (1 + 1/Ti/s);  
    Gd = (Td*s) / (1+Td*s/N);
    H2 = 1 + Gd / Gc2;
    step(feedback(Kp(i)*Gc2*Gp, H2));
    % Legends
    Legend{i, 1} = strcat('PI-D (1), Kp= ', num2str(Kp(i)));
    Legend{i, 2} = strcat('PI-D (2), Kp= ', num2str(Kp(i)));
end
Legend = reshape(Legend, 1, []);
legend(Legend);
grid on;

% Seperated figures for each Kp
Legend = cell(1, 2);
for i = 1:length(Kp)
    figure;
    hold on;
    % Scheme 1
    Gc1 = Kp(i) * (1 + 1/Ti/s);  
    Gd = (Td*s) / (1+Td*s/N);
    H1 = 1 + Gd / Gc1;
    step(feedback(Gc1*Gp, H1));
    % Scheme 2
    Gc2 = (1 + 1/Ti/s);  
    Gd = (Td*s) / (1+Td*s/N);
    H2 = 1 + Gd / Gc2;
    step(feedback(Kp(i)*Gc2*Gp, H2));
    % Options
    Legend{1} = strcat('PI-D (1), Kp= ', num2str(Kp(i)));
    Legend{2} = strcat('PI-D (2), Kp= ', num2str(Kp(i)));
    legend(Legend);
    grid on;
end

% for Kp = 1, two schemes show the same response
% Overshoot: Scheme2 < Scheme1
% t_s: Scheme2 < Scheme1
% t_r: Scheme2 almost equal to Scheme1
