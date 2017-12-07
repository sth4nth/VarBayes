function [A, B, v] = renorm(P)
epoch = 10;
l = 2;
m = 2;
n = 2;

A = normalize(rand(m,l),1);   % q(x|z)
B = normalize(rand(n,l),1);   % q(y|z)
v = normalize(rand(l,1));   % q(z)

A = reshape(A,[m,1,l]);
B = reshape(B,[1,n,l]);
v = reshape(v,[1,1,l]);


for i = 1:epoch
    R = A.*B.*v;               % p(x,y,z);
    R = R./sum(R,3);                 % r(z|x,y);
    
end
