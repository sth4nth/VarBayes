function s = gaBetheEntropy(Sigma)
% Bethe entropy for Gaussian distribution
%   Sigma: covariance matrix of Gaussian
% Written by Mo Chen (sth4nth@gmail.com)
sigma = diag(Sigma);
n = numel(sigma);
c = 0.5*n*log(2*pi*exp(1));
rho = ones(n,n)-Sigma.^2./(sigma.*sigma')+diag(sigma.^2);
s = c+sum(log(rho(:)))/4;