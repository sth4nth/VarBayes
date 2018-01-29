function [U, V, s] = psvd(P, epoch)
% Probabilistic SVD: renormalization for joint distribution
if nargin < 2
    epoch = 100;
end
[m,n] = size(P);
d = min(m,n);
% init
U = normalize(rand(m,d),1);   % q(x|y)
V = normalize(rand(n,d),1);   % q(z|y)
s = normalize(rand(d,1));   % q(y)

UT = reshape(U,[m,1,d]);
VT = reshape(V,[1,n,d]);
ST = reshape(s,[1,1,d]);
for i = 1:epoch
    %% s = q(y)
    T = UT.*VT.*ST;               % q(x,z,y)
    Q = sum(T,3);                 % q(x,z): Q = U*diag(s)*V';
    M  = log(P./Q);
    MT = reshape(M,[d,d,1]);
    
    ST = ST.*exp(sum(sum(UT.*VT.*MT,1),2));
    ST = ST./sum(ST,3);
    %% U = q(x|y)
    T = UT.*VT.*ST;               % q(x,z,y)
    Q = sum(T,3);                 % q(x,z) : Q = U*diag(s)*V';
    M = log(P./Q);
    MT = reshape(M,[d,d,1]);
    
    UT = exp(sum(VT.*(MT+log(T)),2));
    UT = UT./sum(UT,1);
    %% V = q(z|y)
    T = UT.*VT.*ST;               % q(x,z,y)
    Q = sum(T,3);                 % q(x,z) : Q = U*diag(s)*V';
    M = log(P./Q);
    MT = reshape(M,[d,d,1]);

    VT = exp(sum(UT.*(MT+log(T)),1));
    VT = VT./sum(VT,2);
end
U = reshape(UT,size(U));
V = reshape(VT,size(V));
s = reshape(ST,size(s));
