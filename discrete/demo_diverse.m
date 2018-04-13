% TBD
% example that BP does not converge
n = 4;
z = [1;0];
A = zeros(n,n);
A(1,2) = 1;
A(1,3) = 2;
A(2,4) = 3;
A(3,4) = 4;
A(2,3) = 5;
A = A+A';

nodePot = zeros(numel(z),n);
edgePot = repmat(z*z',[1,1,nnz(triu(A))]);


[nodeBel,edgeBel,lnZ] = mrfExact(A,nodePot,edgePot);
[nodeBel0,edgeBel0,L] = mrfBp(A,nodePot,edgePot,10);
plot(L)