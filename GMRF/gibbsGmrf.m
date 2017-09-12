function lnZ = gibbsGmrf(Lambda, eta, mu)
% Compute Gibbs free energy of Gaussian MRF
mu = mu(:);
eta = eta(:);
n = numel(mu);
c = 0.5*(n*log(2*pi)-sum(log(diag(Lambda))));
lnZ = 0.5*mu'*Lambda*mu-mu'*eta+c;
