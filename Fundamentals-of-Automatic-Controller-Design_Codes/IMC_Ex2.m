clc;
clear;
 close all;
 
s = tf('s');
G = 1 / ((s-1)*(s-2));
N = 1 / (s+1)^2;
M = (s-1)*(s-2) / (s+1)^2;
X = (19*s-11) / (s+1);
Y = (s+6) / (s+1);

figure(1);
hold on;
figure(2);
hold on;
figure(3);
hold on;
figure(4);
hold on;

c = [0.5, 1, 3, 20];
Legend = cell(length(c)+1, 1);
for i = 1:length(c)
    % design for type-2 servo control system
    % we need two integrator in K
	b = 6*c(i);  
    a = 6 + 7*c(i); 
    Q = (a*s+b) / (s+c(i)); 
	K = (X+M*Q) / (Y-N*Q);
%     Kred = reduce(K, 3);  % pole zero cancellation in K
%     Kr = tf(Kred);
%     Kzp=zpk(Kred)
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
Qn = (s+6)*(s+1) / (s^2 + 1);   % not asymptotically stable
Kn = (X+M*Qn) / (Y-N*Qn);
Legend{end} = 'new';

figure(1);
step(feedback(Kn*G, 1), 20);
grid on;
legend(Legend);
figure(2);
step(feedback(Kn, G), 12); 
grid on;
legend(Legend);
figure(3);
step(feedback(Kn*G, 1)/s, 15);
grid on;
legend(Legend);
figure(4);
step(feedback(1, Kn*G)/s, 15);
grid on;
legend(Legend);

% increase in C -> increase in the initial value of the control signal ->
% saturation + integral term in the controller -> integral windup