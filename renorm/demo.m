d = 2;
U = normalize(rand(d),1);   % q(x|y)
V = normalize(rand(d),1);   % q(z|y)
s = normalize(rand(d,1));   % q(y)
S = diag(s);
Q2 = U*S*V';          % q(x,z)

m = size(U,1);
n = size(V,1);
U = reshape(U,[m,1,d]);
V = reshape(V,[1,n,d]);
S = reshape(s,[1,1,d]);
Q3 = U.*V.*S;               % q(x,z,y);
% P2 = sum(Q3,3);              % q(x,z)
% maxdiff(Q2,P2)

R = Q3./Q2;                 % r(y|x,z);

P2 = rand(d);
P2 = P2/sum(P2(:));
% P3 = R.*
