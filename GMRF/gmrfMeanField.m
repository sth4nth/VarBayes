function [mu, lb] = gmrfMeanField(x, lambda, L, epoch)
% Mean field for latent Gaussian MRF
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
lb = -inf(1,epoch+1);
for iter = 1:epoch
    for i = 1:numel(mu)
        [~,j,w] = find(L(i,:));             % j~i
        mu(i) = (eta(i)-sum(w.*mu(j)))/dg(i);
    end
    lb(iter+1) = gibbsGmrf(mu, Lambda, eta);
end
lb = lb(2:end);