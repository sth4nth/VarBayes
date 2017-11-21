function mu = gmrfMeanField(x, lambda, L, epoch)
% Mean field for Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 4
    epoch = 10;
end
n = numel(x);
eta = lambda.*x;
Lambda = lambda*speye(n)+L;
dg = diag(Lambda);  
L(sub2ind([n,n],1:n,1:n)) = 0;              % remove diagonal elements
mu = x;
for iter = 1:epoch
    for i = 1:numel(mu)
        [~,j,w] = find(L(i,:));             % j~i
        mu(i) = (eta(i)-sum(w.*mu(j)))/dg(i);
    end
end
