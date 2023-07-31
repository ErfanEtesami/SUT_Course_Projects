clc;
clear;
close all;

syms t;
syms d1 d2 d1d d2d;
syms l1 l2 m1 m2 g;
assume([d1, d2, d1d, d2d, l1, l2, m1, m2, g], 'real');

H01 = Trans('y', d1);
R01 = H01(1:3, 1:3);
H12 = Trans('x', d2);
H02 = H01 * H12;
R02 = H02(1:3, 1:3);

Q = [d1; d2];
Qd = [d1d; d2d];

[Jv1, Jw1] = Jacob(H01, Q);
[Jv2, Jw2] = Jacob(H02, Q);

% syms th1 th2 l1 l2 d;
% assume([th1, th2, l1, l2, d], 'real');
% % H = Rot('z', th1) * Trans('x', l1) * Rot('z', th2) * Trans('x', l2);
% H = Rot('z', th1) * Trans('x', l1) * Rot('z', -th2) * Trans('x', d);
%{
a1 = 1;
a2 = 1;

syms th1 th2;

H01 = Rot('z', th1) * Trans('x', a1);
H12 = Rot('z', th2) * Trans('x', a2);
H02 = H01 * H12;

Q = [th1; th2];

[Jv1, ~] = Jacob(H01, Q);
[Jv2, ~] = Jacob(H02, Q);
%}
%{
syms theta1 h l1 theta2 l2 d3;

H = Rot('z', theta1) * Trans('z', h) * Trans('x', l1) * ...
    Rot('z', theta2) * Trans('x', l2) * Trans('z', d3) * Rot('x', pi);

Q = [theta1, theta2, d3];

[Jv, Jw] = Jacob(H, Q);
J = [Jv; Jw];
w = [0; 0; 0; -1; -2; 0];
tau = J.' * w;
digits(4); 
disp(simplify(vpa(tau))); 
%}
%{
syms o1 o2 o3;

o = [o1, 0, 0;
     0, o2, 0;
     0, 0, o3];
K = inv(Jv.') * o * inv(Jv);
disp(simplify(K));

if K == K.'
    disp('1');
else
    disp('0');
end
%}