clear;
d = 2;
U = normalize(rand(d),1);   % q(x|y)
V = normalize(rand(d),1);   % q(z|y)
s = normalize(rand(d,1));   % q(y)
S = diag(s);
P = U*S*V';          % p(x,z)

[U,V,s] = renorm(P);
S = diag(s);
Q = U*S*V';          % p(x,z)