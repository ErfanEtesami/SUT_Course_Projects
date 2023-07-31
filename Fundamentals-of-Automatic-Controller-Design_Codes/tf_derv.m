function [e, f] = tf_derv(b, a)
% Obtain the first derivative of a given transfer function.

f = conv(a, a);
e1 = conv((length(b)-1:-1:1).*b(1:end-1), a); 
e2 = conv((length(a)-1:-1:1).*a(1:end-1), b);
L0 = length(e1) - length(e2); 
e = [zeros(1, -L0), e1] - [zeros(1, L0), e2];
end