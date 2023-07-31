clc;
clear;
close all;
%{
syms t;
syms th1 th2 th1d th2d;
syms l1 l2 m1 m2 g;
assume([th1, th2, th1d, th2d, l1, l2, m1, m2, g], 'real');

H01 = Rot('z', th1) * Trans('x', l1);
R01 = H01(1:3, 1:3);
H12 = Rot('z', th2) * Trans('x', l2);
H02 = H01 * H12;
R02 = H02(1:3, 1:3);

Q = [th1; th2];
Qd = [th1d; th2d];

[Jv1, Jw1] = Jacob(H01, Q);
[Jv2, Jw2] = Jacob(H02, Q);

Icm01 = R01 * (1/12*m1*l1^2) * R01';
Icm02 = R02 * (1/12*m2*l2^2) * R02';

V01 = Jv1 * Qd;
V02 = Jv2 * Qd;

W01 = Jw1 * Qd;
W02 = Jw2 * Qd;

Vcm01 = V01 + cross(W01, R01*[-l1/2; 0; 0]); 
Vcm02 = V02 + cross(W02, R02*[-l2/2; 0; 0]);

T1 = 1/2*m1*dot(Vcm01, Vcm01) + 1/2*dot(W01, Icm01*W01);
T2 = 1/2*m2*dot(Vcm02, Vcm02) + 1/2*dot(W02, Icm02*W02);
T = T1 + T2;

temp1 = H01*[-l1/2; 0; 0; 1];
temp2 = H02*[-l2/2; 0; 0; 1];
U1 = m1*g*dot([0; 1; 0], temp1(1:3));
U2 = m2*g*dot([0; 1; 0], temp2(1:3));
U = U1 + U2;

L = T-U;

dLdQ1 = diff(L, th1);
dLdQ2 = diff(L, th2);
dLdQd1 = diff(L, th1d);
dLdQd2 = diff(L, th2d);

syms th1t(t) th2t(t) th1dt(t) th2dt(t);
Lt1 = subs(dLdQd1, [th1, th2, th1d, th2d], [th1t, th2t, th1dt, th2dt]);
Lt2 = subs(dLdQd2, [th1, th2, th1d, th2d], [th1t, th2t, th1dt, th2dt]);
temp1 = diff(Lt1, t) - dLdQ1;
temp2 = diff(Lt2, t) - dLdQ2;
%}
%{
syms t;
syms q1 q2 q1d q2d;
syms l1 l2 m1 m2 g;
assume([q1, q2, q1d, q2d, l1, l2, m1, m2, g], 'real');

H01 = Trans('z', q1) * Rot('x', -pi/2);
R01 = H01(1:3, 1:3);
H12 = Trans('z', q2);
H02 = H01 * H12;
R02 = H02(1:3, 1:3);

Q = [q1; q2];
Qd = [q1d; q2d];

[Jv1, Jw1] = Jacob(H01, Q);
[Jv2, Jw2] = Jacob(H02, Q);

V01 = Jv1 * Qd;
V02 = Jv2 * Qd;

Vcm01 = V01; 
Vcm02 = V02;

T1 = 1/2*m1*dot(Vcm01, Vcm01);
T2 = 1/2*m2*dot(Vcm02, Vcm02);
T = T1 + T2;

temp1 = H01*[0; 0; q1; 1];
temp2 = H02*[0; 0; q2; 1];
U1 = m1*g*dot([0; 0; 1], temp1(1:3));
U2 = m2*g*dot([0; 0; 1], temp2(1:3));
U = U1 + U2;

L = T-U;

dLdQ1 = diff(L, q1);
dLdQ2 = diff(L, q2);
dLdQd1 = diff(L, q1d);
dLdQd2 = diff(L, q2d);

syms q1t(t) q2t(t) q1dt(t) q2dt(t);
Lt1 = subs(dLdQd1, [q1, q2, q1d, q2d], [q1t, q2t, q1dt, q2dt]);
Lt2 = subs(dLdQd2, [q1, q2, q1d, q2d], [q1t, q2t, q1dt, q2dt]);
temp1 = diff(Lt1, t) - dLdQ1;
temp2 = diff(Lt2, t) - dLdQ2;
% digits(4); 
% disp(simplify(vpa(tau))); 
%}
%{
syms t;
syms q1 q2 q1d q2d;
syms l1 l2 m1 m2 g;
assume([q1, q2, q1d, q2d, l1, l2, m1, m2, g], 'real');

H01 = Rot('z', q1) * Trans('x', l1);
R01 = H01(1:3, 1:3);
H12 = Rot('z', q2) * Trans('x', l2);
H02 = H01 * H12;
R02 = H02(1:3, 1:3);

Q = [q1; q2];
Qd = [q1d; q2d];

[Jv1, Jw1] = Jacob(H01, Q);
[Jv2, Jw2] = Jacob(H02, Q);

Icm01 = R01 * (1/12*m1*l1^2) * R01';
Icm02 = R02 * (1/12*m2*l2^2) * R02';

V01 = Jv1 * Qd;
V02 = Jv2 * Qd;

W01 = Jw1 * Qd;
W02 = Jw2 * Qd;

Vcm01 = V01 + cross(W01, R01*[-l1/2; 0; 0]); 
Vcm02 = V02 + cross(W02, R02*[-l2/2; 0; 0]);

T1 = 1/2*m1*dot(Vcm01, Vcm01) + 1/2*dot(W01, Icm01*W01);
T2 = 1/2*m2*dot(Vcm02, Vcm02) + 1/2*dot(W02, Icm02*W02);
T = T1 + T2;

temp1 = H01*[-l1/2; 0; 0; 1];
temp2 = H02*[-l2/2; 0; 0; 1];
U1 = m1*g*dot([0; 1; 0], temp1(1:3));
U2 = m2*g*dot([0; 1; 0], temp2(1:3));
U = U1 + U2;

L = T-U;

dLdQ1 = diff(L, q1);
dLdQ2 = diff(L, q2);
dLdQd1 = diff(L, q1d);
dLdQd2 = diff(L, q2d);

syms q1t(t) q2t(t) q1dt(t) q2dt(t);
Lt1 = subs(dLdQd1, [q1, q2, q1d, q2d], [q1t, q2t, q1dt, q2dt]);
Lt2 = subs(dLdQd2, [q1, q2, q1d, q2d], [q1t, q2t, q1dt, q2dt]);
temp1 = diff(Lt1, t) - dLdQ1;
temp2 = diff(Lt2, t) - dLdQ2;
%}
%{
syms t;
syms p1 p1d p2 p2d;
syms l1 l2 m1 m2 g;
assume([p1, p2, p1d, p2d, l1, l2, m1, m2, g], 'real');

H01 = Rot('z', p1) * Trans('x', l1);
R01 = H01(1:3, 1:3);
H12 = Rot('z', p2-p1) * Trans('x', l2);
H02 = H01 * H12;
R02 = H02(1:3, 1:3);

Q = [p1; p2];
Qd = [p1d; p2d];

[Jv1, Jw1] = Jacob(H01, Q);
[Jv2, Jw2] = Jacob(H02, Q);

Icm01 = R01 * (1/12*m1*l1^2) * R01';
Icm02 = R02 * (1/12*m2*l2^2) * R02';

V01 = Jv1 * Qd;
V02 = Jv2 * Qd;

W01 = Jw1 * Qd;
W02 = Jw2 * Qd;

Vcm01 = V01 + cross(W01, R01*[-l1/2; 0; 0]); 
Vcm02 = V02 + cross(W02, R02*[-l2/2; 0; 0]);

T1 = 1/2*m1*dot(Vcm01, Vcm01) + 1/2*dot(W01, Icm01*W01);
T2 = 1/2*m2*dot(Vcm02, Vcm02) + 1/2*dot(W02, Icm02*W02);
T = T1 + T2;

temp1 = H01*[-l1/2; 0; 0; 1];
temp2 = H02*[-l2/2; 0; 0; 1];
U1 = m1*g*dot([0; 1; 0], temp1(1:3));
U2 = m2*g*dot([0; 1; 0], temp2(1:3));
U = U1 + U2;

L = T-U;

dLdQ1 = diff(L, p1);
dLdQ2 = diff(L, p2);
dLdQd1 = diff(L, p1d);
dLdQd2 = diff(L, p2d);

syms p1t(t) p2t(t) p1dt(t) p2dt(t);
Lt1 = subs(dLdQd1, [p1, p2, p1d, p2d], [p1t, p2t, p1dt, p2dt]);
Lt2 = subs(dLdQd2, [p1, p2, p1d, p2d], [p1t, p2t, p1dt, p2dt]);
temp1 = diff(Lt1, t) - dLdQ1;
temp2 = diff(Lt2, t) - dLdQ2;
%}
syms t;
syms d th dd thd;
syms l m M g;
assume([d, th, dd, thd, l, m, M, g], 'real');

H01 = Trans('z', d);
R01 = H01(1:3, 1:3);
H12 = Rot('z', th) * Trans('x', l);
H02 = H01 * H12;
R02 = H02(1:3, 1:3);

Q = [d; th];
Qd = [dd; thd];

[Jv1, Jw1] = Jacob(H01, Q);
[Jv2, Jw2] = Jacob(H02, Q);

Icm01 = R01 * 0 * R01';
Icm02 = R02 * (1/12*m*l^2) * R02';

V01 = Jv1 * Qd;
V02 = Jv2 * Qd;

W01 = Jw1 * Qd;
W02 = Jw2 * Qd;

Vcm01 = V01; 
Vcm02 = V02 + cross(W02, R02*[-l/2; 0; 0]);

T1 = 1/2*M*dot(Vcm01, Vcm01);
T2 = 1/2*m*dot(Vcm02, Vcm02) + 1/2*dot(W02, Icm02*W02);
T = T1 + T2;

temp1 = H01*[0; 0; d; 1];
temp2 = H02*[-l/2; 0; 0; 1];
U1 = M*g*dot([0; 1; 0], temp1(1:3));
U2 = m*g*dot([0; 1; 0], temp2(1:3));
U = U1 + U2;

L = T-U;

dLdQ1 = diff(L, d);
dLdQ2 = diff(L, th);
dLdQd1 = diff(L, dd);
dLdQd2 = diff(L, thd);

syms dt(t) tht(t) ddt(t) thdt(t);
Lt1 = subs(dLdQd1, [d, th, dd, thd], [dt, tht, ddt, thdt]);
Lt2 = subs(dLdQd2, [d, th, dd, thd], [dt, tht, ddt, thdt]);
temp1 = diff(Lt1, t) - dLdQ1;
temp2 = diff(Lt2, t) - dLdQ2;
% digits(4); 
% disp(simplify(vpa(tau))); 