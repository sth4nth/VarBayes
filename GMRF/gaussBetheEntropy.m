function v = gaussBetheEntropy(Sigma)
% Bethe entropy for Gaussian distribution
sigma = diag(Sigma);
n = numel(sigma);
c = 0.5*n*log(2*pi*exp(1));
rho = ones(n,n)-Sigma.^2./(sigma.*sigma')+diag(sigma.^2);
v = c+sum(log(rho(:)))/4;