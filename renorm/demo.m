clear;
d = 2;
U = normalize(rand(d),1);   % q(x|y)
V = normalize(rand(d),1);   % q(z|y)
s = normalize(rand(d,1));   % q(y)
S = diag(s);
Q = U*S*V';          % q(x,z)

m = size(U,1);
n = size(V,1);
UT = reshape(U,[m,1,d]);
UU = reshape(UT,size(U));

VT = reshape(V,[1,n,d]);
ST = reshape(s,[1,1,d]);
QT = UT.*VT.*ST;               % q(x,z,y);
P = sum(QT,3);              % q(x,z)
maxdiff(Q,P)
% R = QT./Q;                 % r(y|x,z);

%% Exz|y[M(x,z)]
M = rand(d,d);
E = zeros(d,1);
for x = 1:d
    for y = 1:d
        for z = 1:d
            E(y) = E(y)+U(x,y)*M(x,z)*V(z,y);
        end
    end
end
s = diag(U'*M*V);

MT = reshape(M,[d,d,1]);
ST = sum(sum(UT.*VT.*MT,1),2);
%% Ez|y[M(x,z,y)]
MT = rand(d,d,d);
E = zeros(d,d);
for x = 1:d
    for y = 1:d
        for z = 1:d
            E(x,y) = E(x,y)+V(z,y)*MT(x,z,y);
        end
    end
end
ET = sum(VT.*MT,2);

%% Ez|y[M(x,z)]
M = rand(d,d); 
E = zeros(d,d);
for x = 1:d
    for y = 1:d
        for z = 1:d
            E(x,y) = E(x,y)+V(z,y)*M(x,z);
        end
    end
end
MT = reshape(M,[d,d,1]);
ET = sum(VT.*MT,2);
