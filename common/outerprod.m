function T = outerprod(X)
% Compute outer product of vectors
%   X: d x n vectors
%   T: d x d x ... nth-order tensor
T = X(:,1);
[d,n] = size(X);
for i = 2:n
    sz = ones(1,i);
    sz(i)= d;
    T = T.*reshape(X(:,i),sz);
end
