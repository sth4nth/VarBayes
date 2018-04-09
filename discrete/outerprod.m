function T = outerprod(X, dim)
[d,n] = size(X);
T = 1;
for i = 1:n
    T = T.*X(:,i);
end