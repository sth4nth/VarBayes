function [mu, LB] = gmrfMeanField(x, lambda, L, epoch)
% Mean field for latent Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 4
    epoch = 10;
end
n = numel(x);
eta = lambda.*x;
Lambda = lambda+reshape(diag(L),size(x));  % diagonal of Lambda
dg = sub2ind([n,n],1:n,1:n);
L(dg) = 0;              % remove diagonal elements
mu = x;

C = n*log(2*pi)-sum(log(Lambda(:)));
LB = -inf(1,epoch+1);
for iter = 1:epoch
    for i = 1:numel(mu)
        [~,j,w] = find(L(i,:));             % neighbors
        mu(i) = (eta(i)-sum(w.*mu(j)))/Lambda(i);
    end
    T = 0.5*Lambda.*mu.^2-eta.*mu;
    LB(iter+1) = 0.5*(C-sum(T(:))); 
end
LB = LB(2:end);