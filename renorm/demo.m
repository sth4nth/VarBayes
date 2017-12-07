A = normalize(rand(2),1);   % p(x|z)
B = normalize(rand(2),1);   % p(y|z)
v = normalize(rand(2,1));   % p(z)
P2 = A*diag(v)*B';          % p(x,y)

l = numel(v);
m = size(A,1);
n = size(B,1);
A = reshape(A,[m,1,l]);
B = reshape(B,[1,n,l]);
v = reshape(v,[1,1,l]);
P3 = A.*B.*v;               % p(x,y,z);
P = sum(P3,3);              % p(x,y)
maxdiff(P,P2)

P = P3./P2;                 % p(z|x,y);
