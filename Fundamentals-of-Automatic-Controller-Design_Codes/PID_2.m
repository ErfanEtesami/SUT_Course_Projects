clc;
clear;
close all;

s = tf('s');
Gp = 1 / ((s+1)^3);

%{
figure;
hold on;
Kp = [0.1:0.1:1];
Legend = cell(length(Kp));
for i = 1:length(Kp)
    H = feedback(Kp(i)*Gp, 1);
    step(H);
    Legend{i} = strcat('Kp = ', num2str(Kp(i)));
end
Legend = Legend(~cellfun('isempty', Legend));
legend(Legend);
%}

% increse in Kp -> decrease in e_ss
% closed loop response has e_ss because open loop does not have an
% integrator
Kp = 1;

%{
figure;
hold on;
Ti = [0.7:0.1:1.5];
t = 0:0.1:20;
Legend = cell(length(Ti));
for i = 1:length(Ti)
    Gc = Kp * (1 + 1/Ti(i)/s);
    H = feedback(Gc*Gp, 1);
    step(H, t);
    Legend{i} = strcat('Ti = ', num2str(Ti(i)));
end
Legend = Legend(~cellfun('isempty', Legend));
legend(Legend);
%}

% increse in Ti -> decrease in overshoot
% closed loop response has zero e_ss because open loop has an integrator
Ti = 1;

%{
figure;
hold on;
Td = [0.1:0.2:2];
t = 0:0.1:20;
Legend = cell(length(Td));
for i = 1:length(Td)
    Gc = Kp * (1 + 1/Ti/s + Td(i)*s);
    H = feedback(Gc*Gp, 1);
    step(H, t);
    Legend{i} = strcat('Td = ', num2str(Td(i)));
end
Legend = Legend(~cellfun('isempty', Legend));
legend(Legend);
%}

% increse in Td -> decrease in oscillations
Td = 1;

%{
figure;
Gc = Kp * (1 + 1/Ti/s + Td*s);
step(feedback(Gc*Gp, 1));
hold on;
N = [100, 1000, 10000, 1:10];
t = 0:0.1:10;
Legend = cell(1+length(N));
Legend{1} = 'Without filter';
for i = 1:length(N)
    Gc = Kp * (1 + 1/Ti/s + Td*s/(1+Td*s/N(i)));
    H = feedback(Gc*Gp, 1);
    step(H, t);
    Legend{i+1} = strcat('N = ', num2str(N(i)));
end
Legend = Legend(~cellfun('isempty', Legend));
legend(Legend);
%}

% for N>=10, response is almost the same
N = 10;

%{
Gc = Kp * (1 + 1/Ti/s + Td*s/(1+Td*s/N));   % Normal PID

% Scheme 1
Gc1 = Kp * (1 + 1/Ti/s);  
Gd = (Td*s) / (1+Td*s/N);
H = 1 + Gd / Gc1;

figure;
step(feedback(Gc*Gp, 1));
hold on;
step(feedback(Gc1*Gp, H));
legend('PID', 'PI-D');
grid on;

% Overshoot: PI-D > PID
% PI-D starts with a smaller slope (smaller acceleration) compared to PID
% t_s: PI-D almost equal to PID

% Scheme 2
Gc = Kp * (1 + 1/Ti/s + Td*s/(1+Td*s/N));   % Normal PID
Gc2 = (1 + 1/Ti/s);
Gd = (Td*s) / (1+Td*s/N);
H = 1 + Gd / Gc2;

figure;
step(feedback(Gc*Gp, 1));
hold on;
step(feedback(Gc2*Kp*Gp, H));
legend('PID', 'PI-D');
grid on;
% Overshoot: PI-D > PID
% PI-D starts with a smaller slope (smaller acceleration) compared to PID
% t_s: PI-D almost equal to PID
%}

% for Kp = 1, two schemes show the same response

% Scheme 1 vs Scheme 2
Kp = 0.5;

Gc = Kp * (1 + 1/Ti/s + Td*s/(1+Td*s/N));

Gpi1 = Kp * (1 + 1/Ti/s);
Gd1 = (Td*s) / (1+Td*s/N);
H1 = 1 + Gd1 / Gpi1;

Gpi2 = (1 + 1/Ti/s);
Gd2 = (Td*s) / (1+Td*s/N);
H2 = 1 + Gd2 / Gpi2;

figure;
hold on;
step(feedback(Gc*Gp, 1));
step(feedback(Gpi1*Gp, H1));
step(feedback(Gpi2*Kp*Gp, H2));
Legend = cell(3);    
Legend{1} = strcat('PID, Kp = ', num2str(Kp));
Legend{2} = strcat('PI-D (1), Kp = ', num2str(Kp));
Legend{3} = strcat('PI-D (2), Kp = ', num2str(Kp));
Legend = Legend(~cellfun('isempty', Legend));
legend(Legend);

% Scheme 1 vs Scheme 2
Kp = 2;

Gc = Kp * (1 + 1/Ti/s + Td*s/(1+Td*s/N));

Gpi1 = Kp * (1 + 1/Ti/s);
Gd1 = (Td*s) / (1+Td*s/N);
H1 = 1 + Gd1 / Gpi1;

Gpi2 = (1 + 1/Ti/s);
Gd2 = (Td*s) / (1+Td*s/N);
H2 = 1 + Gd2 / Gpi2;

figure;
hold on;
step(feedback(Gc*Gp, 1));
step(feedback(Gpi1*Gp, H1));
step(feedback(Gpi2*Kp*Gp, H2));
Legend = cell(3);    
Legend{1} = strcat('PID, Kp = ', num2str(Kp));
Legend{2} = strcat('PI-D (1), Kp = ', num2str(Kp));
Legend{3} = strcat('PI-D (2), Kp = ', num2str(Kp));
Legend = Legend(~cellfun('isempty', Legend));
legend(Legend);

% Overshoor: Scheme2 < Scheme1
% t_s: Scheme2 < Scheme1
%}