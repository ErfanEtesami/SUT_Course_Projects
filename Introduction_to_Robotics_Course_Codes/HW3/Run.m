clc;
clear;
close all;

X = [100, 72, -5];  % cm
Y = [65, 43, 85];   % cm
Z = [-15, 0, 5];    % cm

for i = 1:length(X)
    Theta = InversePos_RRR(X(i), Y(i), Z(i));
    
    if Theta == [0; 0; 0]
        disp('Impossible!');
    else
        fprintf("col %d: theta1 = %.2f, theta2 = %.2f, theta3 = %.2f \n", i,...
                Theta(1), Theta(2), Theta(3));
    end
    
end

%{
% simulink
theta1 = th1(2);
theta2 = th2(2);
dist3 = d3(2);
%}

