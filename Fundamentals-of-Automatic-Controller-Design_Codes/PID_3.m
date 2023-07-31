clc;
clear;
close all;

s = tf('s');
Gp = 1 / ((s+1)^3);

[Kc, PM, Wg, Wp] = margin(Gp);
Tc = 2*pi/Wg;
N = 10;

[Gc1, Kp1, Ti1, Td1] = ZN(3, [Kc, Tc, N]);
Gcl1 = feedback(Gc1*Gp, 1);

figure;
grid on;
hold on;
step(Gcl1, 20);
rb = 0.5;
pb = [10:10:70];
Legend = cell(1+length(pb));
Legend{1} = 'Not Modified';
for i = 1:length(pb)
    [Gc2, Kp2, Ti2, Td2] = ZN(3, [Kc, Tc, rb, pb(i), N]);
    Gcl2 = feedback(Gc2*Gp, 1);
    step(Gcl2, 20);
    Legend{i+1} = strcat('pb = ', num2str(pb(i)));
end
Legend = Legend(~cellfun('isempty', Legend));
legend(Legend);

% increse in pb -> decrease in overshoot and oscillations
pb = 45;

figure;
grid on;
hold on;
step(Gcl1, 10);
rb = [0.1:0.1:1];
Legend = cell(1+length(rb));
Legend{1} = 'Not Modified';
for i = 1:length(rb)
    [Gc3, Kp3, Ti3, Td3] = ZN(3, [Kc, Tc, rb(i), pb, N]);
    Gcl3 = feedback(Gc3*Gp, 1);
    step(Gcl3, 10);
    Legend{i+1} = strcat('rb = ', num2str(rb(i)));
end
Legend = Legend(~cellfun('isempty', Legend));
legend(Legend);

% decrease in rb -> decrese in overshoot and oscillations and increse in t_s
rb = 0.45;
