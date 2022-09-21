clc;
clear;
close all;

syms s t0 t1 v0 v1 t q0 qf q1;

% [a1, a_subs1] = cubicPoly(1, 0, 1, 0, 0, q0, qf);
% disp(simplify(a_subs1));

% [a2, a_subs2] = cubicPoly(1, 0, s, 0, 0, q0, af);
% disp(simplify(a_subs2));

% [a3, a_subs3] = quinticPoly(1, 0, 2, 0, 0, 0, 0, q0, qf);
% disp(simplify(a_subs3));
% t = 0:0.01:2;
% q = 25*t.^3 - 18.75*t.^4 + 3.75*t.^5;
% qd = 75*t.^2 -75*t.^3 + 18.75*t.^4;
% qdd = 150*t - 225*t.^2 + 75*t.^3;
% figure;
% plot(t, q);
% figure;
% plot(t, qd);
% figure;
% plot(t, qdd);

% [a4, a_subs4, b4, b_subs4] = cubicPoly(2, t0, t1, v0, v1, q0, q1);
% % disp(simplify(a_subs4));
% disp(simplify(b_subs4));

% [~, ~, ~, ~, s1, s1d, s1dd] = cubicPoly(2, 0, 2, 0, 0, 10, 40);
% [~, ~, ~, ~, s2, s2d, s2dd] = cubicPoly(2, 2, 4, 0, 0, 40, 30);
% [~, ~, ~, ~, s3, s3d, s3dd] = cubicPoly(2, 4, 6, 0, 0, 30, 90);
% [~, ~, ~, ~, s1, s1d, s1dd] = quinticPoly(2, 0, 2, 0, 0, 0, 0, 10, 40);
% [~, ~, ~, ~, s2, s2d, s2dd] = quinticPoly(2, 2, 4, 0, 0, 0, 0, 40, 30);
% [~, ~, ~, ~, s3, s3d, s3dd] = quinticPoly(2, 4, 6, 0, 0, 0, 0, 30, 90);
% angle1 = double(subs(s1, t, [0:0.05:2-0.05]));
% angle2 = double(subs(s2, t, [2:0.05:4-0.05]));
% angle3 = double(subs(s3, t, [4:0.05:6]));
% angle = [angle1, angle2, angle3];
% velocity1 = double(subs(s1d, t, [0:0.05:2-0.05]));
% velocity2 = double(subs(s2d, t, [2:0.05:4-0.05]));
% velocity3 = double(subs(s3d, t, [4:0.05:6]));
% velocity = [velocity1, velocity2, velocity3];
% acceleration1 = double(subs(s1dd, t, [0:0.05:2-0.05]));
% acceleration2 = double(subs(s2dd, t, [2:0.05:4-0.05]));
% acceleration3 = double(subs(s3dd, t, [4:0.05:6]));
% acceleration = [acceleration1, acceleration2, acceleration3];
% t = 0:0.05:6;
% figure;
% plot(t, angle);
% grid on;
% figure;
% plot(t, velocity);
% grid on;
% figure;
% plot(t, acceleration);
% grid on;

[a4, a_subs4, b4, b_subs4] = cubicPoly(2, t0, t0+2, 0, 1, q0, q1);
disp(simplify(b_subs4));

function [a, a_subs, b, b_subs, q, qd, qdd] = cubicPoly(key, in_t0, in_te, in_v0, in_vf, in_q0, in_qf)
syms t t0 te v0 vf q0 qf;
a = []; a_subs = []; b = []; b_subs=[]; q = []; qd = []; qdd = [];
X = [q0; v0; qf; vf];

if key==1
    A = [1, t0, t0^2, t0^3;
         0, 1, 2*t0, 3*t0^2;
         1, te, te^2, te^3;
         0, 1, 2*te, 3*te^2];
    
    a = inv(A) * X;
    a_subs = subs(a, [t0, te, v0, vf, q0, qf], [in_t0, in_te, in_v0, in_vf, in_q0, in_qf]);
    a0 = a_subs(1); a1 = a_subs(2); a2 = a_subs(3); a3 = a_subs(4);
    
    q = a0 + a1*t + a2*t.^2 + a3*t.^3;
    qd = diff(q, t);
    qdd = diff(qd, t);
    
elseif key==2
    B = [1, 0, 0, 0;
         0, 1, 0, 0;
         1, (te-t0), (te-t0)^2, (te-t0)^3;
         0, 1, 2*(te-t0), 3*(te-t0)^2];
    
    b = inv(B) * X;
    b_subs = subs(b, [t0, te, v0, vf, q0, qf], [in_t0, in_te, in_v0, in_vf, in_q0, in_qf]);
    b0 = b_subs(1); b1 = b_subs(2); b2 = b_subs(3); b3 = b_subs(4);
    
    q = b0 + b1*(t-in_t0) + b2*(t-in_t0).^2 + b3*(t-in_t0).^3;
    qd = diff(q, t);
    qdd = diff(qd, t);
end

end

function [a, a_subs, b, b_subs, q, qd, qdd] = quinticPoly(key, in_t0, in_te, in_v0, in_vf, in_ac0, in_acf, in_q0, in_qf)
syms t t0 te v0 vf ac0 acf q0 qf;
a = []; a_subs = []; b = []; b_subs=[]; q = []; qd = []; qdd = [];
X = [q0; v0; ac0; qf; vf; acf];

if key==1
    A = [1, t0, t0^2, t0^3, t0^4, t0^5;
         0, 1, 2*t0, 3*t0^2, 4*t0^3, 5*t0^4;
         0, 0, 2, 6*t0, 12*t0^2, 20*t0^3;
         1, te, te^2, te^3, te^4, te^5;
         0, 1, 2*te, 3*te^2, 4*te^3, 5*te^4;
         0, 0, 2, 6*te, 12*te^2, 20*te^3];
    
    a = inv(A) * X;
    a_subs = subs(a, [t0, te, v0, vf, ac0, acf, q0, qf], [in_t0, in_te, in_v0, in_vf, in_ac0, in_acf, in_q0, in_qf]);
    a0 = a_subs(1); a1 = a_subs(2); a2 = a_subs(3); a3 = a_subs(4); a4 = a_subs(5); a5 = a_subs(6);
    
    q = a0 + a1*t + a2*t.^2 + a3*t.^3 + a4*t.^4 + a5*t.^5;
    qd = diff(q, t);
    qdd = diff(qd, t);
    
elseif key==2
    B = [1, 0, 0, 0, 0, 0;
         0, 1, 0, 0, 0, 0;
         0, 0, 2, 0, 0, 0;
         1, (te-t0), (te-t0)^2, (te-t0)^3, (te-t0)^4, (te-t0)^5;
         0, 1, 2*(te-t0), 3*(te-t0)^2, 4*(te-t0)^3, 5*(te-t0)^4;
         0, 0, 2, 6*(te-t0), 12*(te-t0)^2, 20*(te-t0)^3];
    
    b = inv(B) * X;
    b_subs = subs(b, [t0, te, v0, vf, ac0, acf, q0, qf], [in_t0, in_te, in_v0, in_vf, in_ac0, in_acf, in_q0, in_qf]);
    b0 = b_subs(1); b1 = b_subs(2); b2 = b_subs(3); b3 = b_subs(4); b4 = b_subs(5); b5 = b_subs(6);
    
    q = b0 + b1*(t-in_t0) + b2*(t-in_t0).^2 + b3*(t-in_t0).^3 + b4*(t-in_t0).^4 + b5*(t-in_t0).^5;
    qd = diff(q, t);
    qdd = diff(qd, t);
end

end

function [a, a_subs, b, b_subs, q, qd, qdd] = LSPB(key, in_t0, in_te, in_v0, in_vf, in_q0, in_qf)
syms t t0 te v0 vf q0 qf;
a = []; a_subs = []; b = []; b_subs=[]; q = []; qd = []; qdd = [];
X = [q0; v0; qf; vf];

if key==1
    A = [1, t0, t0^2, t0^3;
         0, 1, 2*t0, 3*t0^2;
         1, te, te^2, te^3;
         0, 1, 2*te, 3*te^2];
    
    a = inv(A) * X;
    a_subs = subs(a, [t0, te, v0, vf, q0, qf], [in_t0, in_te, in_v0, in_vf, in_q0, in_qf]);
    a0 = a_subs(1); a1 = a_subs(2); a2 = a_subs(3); a3 = a_subs(4);
    
    q = a0 + a1*t + a2*t.^2 + a3*t.^3;
    qd = diff(q, t);
    qdd = diff(qd, t);
    
elseif key==2
    B = [1, 0, 0, 0;
         0, 1, 0, 0;
         1, (te-t0), (te-t0)^2, (te-t0)^3;
         0, 1, 2*(te-t0), 3*(te-t0)^2];
    
    b = inv(B) * X;
    b_subs = subs(b, [t0, te, v0, vf, q0, qf], [in_t0, in_te, in_v0, in_vf, in_q0, in_qf]);
    b0 = b_subs(1); b1 = b_subs(2); b2 = b_subs(3); b3 = b_subs(4);
    
    q = b0 + b1*(t-in_t0) + b2*(t-in_t0).^2 + b3*(t-in_t0).^3;
    qd = diff(q, t);
    qdd = diff(qd, t);
end

end