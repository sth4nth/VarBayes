function mu = gmrfMeanField(x, lambda, L, epoch)
% Mean field for latent Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 4
    epoch = 10;
end
n = numel(x);
eta = lambda.*x;
Lambda = lambda+reshape(diag(L),size(x));  % diagonal of Lambda
L(sub2ind([n,n],1:n,1:n)) = 0;              % remove diagonal elements
mu = x;
for iter = 1:epoch
    for i = 1:numel(mu)
        [~,j,w] = find(L(i,:));             % neighbors
        mu(i) = (eta(i)-sum(w.*mu(j)))/Lambda(i);
    end
end