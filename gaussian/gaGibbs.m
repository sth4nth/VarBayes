function lnZ = gaGibbs(eta, Lambda, mu)
% Gibbs energy of Gaussian MRF
%   mu: mean field result
%   Lambda, eta: Ga MRF parameters
% Written by Mo Chen (sth4nth@gmail.com)
mu = mu(:);
eta = eta(:);
sigma = 1./diag(Lambda);
c = 0.5*sum(log(2*pi*sigma));
lnZ = -0.5*mu'*Lambda*mu+eta'*mu+c;