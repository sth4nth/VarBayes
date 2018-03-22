function lnZ = gaGibbsEnergy(eta, Lambda, mu)
% Gibbs energy of Gaussian MRF
%   eta, Lambda: Gausiian MRF parameters
%   mu: mean field solution
% Written by Mo Chen (sth4nth@gmail.com)
mu = mu(:);
eta = eta(:);
sigma = 1./diag(Lambda);
c = 0.5*sum(log(2*pi*sigma));
lnZ = -0.5*mu'*Lambda*mu+eta'*mu+c;