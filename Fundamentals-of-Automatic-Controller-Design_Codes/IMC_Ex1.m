clc;
clear;
close all;

s = tf('s');
lambda = [1, 0.2, 0.1];
G = 2 / (s+1);
Q = cell(length(lambda), 1);

Legend = cell(length(lambda), 1);

for i = 1:length(lambda)
    Q{i} = (s+1) / (2*(lambda(i)*s+1));
end
figure;
hold on;
for i = 1:length(lambda)
    step(Q{i}, 4);
    Legend{i} = ['lambda=', num2str(lambda(i))];
end
grid on;
legend(Legend);
axis([0, 4, 0, 5]);

figure;
step(G*Q{3});
grid on;

lambda = 0.1;
Kc = 5;
Td = 0;
Ti = 1;
b = 1;
c = 0;
N0 = inf;
N = 0.7;
Tt0 = inf;
gamma = [0, 0.5, 1, 2];
Tt = 1 ./ gamma;

% gamma = 1 is the best choice.