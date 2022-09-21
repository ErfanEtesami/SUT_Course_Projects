%% General
clc;
clear;
close all;
% s
s = tf('s');
% Parameters
L = 1;      % m
d = 5/100;  % m
a = 2/100;  % m
m = 1;      % Kg
c = 0.5;    % Kg.m/s
g = 9.8;    % m/(s^2)
nG = 5;
nSat = 10;
nVR = 1/2;
% Transfer Functions
VR = 0*s + nVR;
P = (g*d) / ((7/5*L*s^2)+(c/m*L*s));
G = (0.0274) / ((0.003228*s^2)+(0.003508*s));
Gp = G*(-1/nG)*P;
K = -2941.2*(s^2 + 0.4*s + 0.0425)/((s+25)^2);
Gps = K*Gp*VR;

%% getFOTD & optApp
% Gpws = minreal(Gps*(s^2));
% [K1, L1, T1] = getFOTD(Gpws, 0); % FR (Frequency Response)
% [K2, L2, T2] = getFOTD(Gpws, 1); % TF (Transfer Function)
% Gr = optApp(Gpws, 0, 1, 1);

%% Controllers
Kdc = dcgain(Gps);
[Kc, Pm, Wp, Wg] = margin(Gps);
Tc = 2*pi/Wp;
N = 10;
Gcl = cell(3, 1);

% ZN - FR
[Gc1, Kp1, Ti1, Td1, H1] = ZN(3, [Kc, Tc, N]);
Gcl{1} = feedback(Gc1*Gps, H1);
% pidstd(Gc1)     % ZN-FR
% zpk(Gc1)        % ZN-FR
% figure;
% step(Gcl{1});
% grid on;
% legend('ZN-FR');

% ZN - Modified
rb = 1;
pb = 70;
[Gc2, Kp2, Ti2, Td2, H2] = ZN(3, [Kc, Tc, rb, pb, N]);
Gcl{2} = feedback(Gc2*Gps, H2);
% pidstd(Gc2)     % ZN-Modified
% zpk(Gc2)        % ZN-Modified
% figure;
% step(Gcl{2});
% grid on;
% legend('ZN-Modified');

% AH - FR
[Gc3, Kp3, Ti3, Td3, H3] = AH(3, 2, [Kdc, Kc, Tc, N]);
Gcl{3} = feedback(Gc3*Gps, H3);
% pidstd(Gc3)     % AH-FR
% zpk(Gc3)        % AH-FR
% figure;
% step(Gcl{3});
% grid on;
% legend('AH-FR');

% All together
% figure;
% hold on;
% for i = 1:size(Gcl, 1)
%     step(Gcl{i});
% end
% legend('ZN-FR', 'ZN-Modified', 'AH-FR', 'Location', 'southeast');
% grid on;
% box on;

%% Simulink
% stepinfo(ScopeData(:, 2), ScopeData(:, 1), L/2)
% figure;
% plot(ScopeData(:, 1), ScopeData(:, 2));
% grid on;

%% Q6
% Margins
[GM, PM, WP, WG] = margin(Gc2*Gps);
GM = 20*log10(GM);
% Sensitivities
loops = loopsens(Gps, Gc2); 
S = loops.So;
T = loops.To;
% figure;
% opt = bodeoptions('cstprefs');
% opt.PhaseVisible = 'off';
% bodeplot(S, T, opt);
% grid on;
% legend('S', 'T', 'Location', 'southwest');
