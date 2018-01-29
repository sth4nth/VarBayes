clear;
d = 2;
U0 = normalize(rand(d),1);   % q(x|y)
V0 = normalize(rand(d),1);   % q(z|y)
s0 = normalize(rand(d,1));   % q(y)
P = U0*diag(s0)*V0';         % p(x,z)

[U,V,s] = psvd(P);
Q = U*diag(s)*V';          % q(x,z)

maxdiff(P,Q)