function [U, V, s] = renorm(P, epoch)
[m,n] = size(P);
d = min(m,n);
% init
U = normalize(rand(m,d),1);   % q(x|y)
V = normalize(rand(n,d),1);   % q(z|y)
s = normalize(rand(d,1));   % q(y)
for i = 1:epoch
    Q = U*diag(s)*V';
    M = log(P./Q);
    s = s.*exp(diag(U'*M*V));
    s = normalize(s);
    
    UT = reshape(U,[m,1,d]);
    VT = reshape(V,[1,n,d]);
    ST = reshape(s,[1,1,d]);
    T = UT.*VT.*ST;               % tensor: q(x,z,y)
    
    MT = reshape(M,[d,d,1]);
    E2 =  sum(VT.*MT,2);
    E3 = sum(VT.*log(T),2);
    UT = exp(E2+E3);
    U = normalize(U,1);
%     V =
    V = normalize(V,1);
end
