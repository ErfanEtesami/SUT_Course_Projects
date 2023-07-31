clc;
clear;
close all;

X = [46, -10];  % cm
Y = [45, 40];   % cm
Z = [-74, 55];  % cm

for i = 1:length(X)
    Theta = InversePos_Puma(X(i), Y(i), Z(i));
    
    if Theta == [inf; inf; inf]
        disp('Impossible!');
    else
        fprintf("col %d: theta1 = %.4f (deg), theta2 = %.4f (deg), theta3 = %.4f (deg) \n", i,...
                Theta(1), Theta(2), Theta(3));
    end
    
end

%{
% simulink
theta1 = th1(2);
theta2 = th2(2);
dist3 = d3(2);
%}

