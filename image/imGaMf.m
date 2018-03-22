function mu = imGaMf(x, lambda, d, J, epoch)
% Image Gaussian mean field
%   J: L_{ij}
%   d: L_{ii}
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 5
    epoch = 10;
end
[m,n] = size(x);
stride = [-1,1,-m,m];
eta = lambda.*x;
D = (lambda+d).*ones(m,n);
mu = x;
for t = 1:epoch
    for j = 1:n
        for i = 1:m
            pos = i + m*(j-1);
            ne = pos + stride;
            ne([i,i,j,j] == [1,m,1,n]) = [];
            mu(i,j) = (eta(i,j)-sum(J.*mu(ne)))/D(i,j);
        end
    end
end 

