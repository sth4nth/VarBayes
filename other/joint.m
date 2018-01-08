d = 2;
s = normalize(rand(d,1)); % q(y)
S = diag(s);
U = normalize(rand(d,d),1); % q(x|y)
V = normalize(rand(d,d),1); % q(z|y)
M = U*S*V';                 % p(x,z)


R =                             % r(y|x,z)
                            