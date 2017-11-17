function M = setdiag(M, v)
% Set the diagonal of matrix M to be vector v
%   M: n x n matrix
%   v: n vector
% Written by Mo Chen (sth4nth@gmail.com).
[m,n] = size(M);
assert(m==n);
assert(numel(v)==n || numel(v)==1);
M(sub2ind([n,n],1:n,1:n)) = v;


