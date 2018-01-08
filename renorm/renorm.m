function [U, V, s] = renorm(P, epoch)
[m,n] = size(P);
d = min(m,n);
% init
U = normalize(rand(m,d),1);   % q(x|y)
V = normalize(rand(n,d),1);   % q(z|y)
s = normalize(rand(d,1));   % q(y)
% S = diag(s);
% M = U*S*V';
for i = 1:epoch
%     U = reshape(U,[m,1,d]);
%     V = reshape(V,[1,n,d]);
%     S = reshape(s,[1,1,d]);
%     
%     Q3 = U.*V.*S;               % q(x,z,y);
%     R = Q3./sum(Q,3);           % r(y|x,z);
%     P3 = R.*P;                  % p(x,z)r(y|x,z)
    Q = U*diag(s)*V';
    M = log(P./Q);
    s = s.*exp(diag(U'*M*V));
    s = normalize(s);
%     U = 
    U = normalize(U,1);
%     V =
    V = normalize(V,1);
end
