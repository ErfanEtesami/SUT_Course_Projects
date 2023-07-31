clc;
clear;
close all;

s = tf('s');
G = (s-2) / ((s-1)*(s+2));
N = (s-2) / (s+1)^2;
M = (s-1)*(s+2) / (s+1)^2;
X = -2.5/(s + 1.0) - 2.75;
Y = 3.75/(s + 1.0) + 1.0;

figure(1);
hold on;
figure(2);
hold on;
figure(3);
hold on;
figure(4);
hold on;

c = [0.5, 1, 2];
Legend = cell(length(c), 1);
for i = 1:length(c)
    % design for type-2 servo control system
    % we need two integrator in K
	b = -19*c(i) / 8;  
    a = -(32.5*c(i)+19) / 8; 
    Q = (a*s+b) / (s+c(i)); 
	K = (X+M*Q) / (Y-N*Q);
%     Kred = reduce(K, 3);  % pole zero cancellation in K
%     Kr = tf(Kred);
	figure(1);
	step(feedback(K*G, 1), 20); % step response
	figure(2);
	step(feedback(K, G), 12);   % control signal for step command
    figure(3);
	step(feedback(K*G, 1)/s, 15);   % ramp response
    figure(4);
    step(feedback(1, K*G)/s, 15);   % error for ramp command
    Legend{i} = ['c=', num2str(c(i))];
end

figure(1);
grid on;
legend(Legend);
figure(2);
grid on;
legend(Legend);
figure(3);
grid on;
legend(Legend);
figure(4);
grid on;
legend(Legend);

% increase in C -> increase in the initial value of the control signal ->
% saturation + integral term in the controller -> integral windup