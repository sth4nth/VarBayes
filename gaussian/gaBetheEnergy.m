function lnZ = gaBetheEnergy(eta, Lambda, mu, Sigma)
% Bethe energy of Gaussian MRF 
% This function is valid only for stationary solution, since at equilibrium
% terms are canceled which simplify the calculuation
%   eta, Lambda: Gaussian MRF paramters
%   mu, Sigma: stationary solution of marginal by BP
% Written by Mo Chen (sth4nth@gmail.com)
E = -0.5*mu*Lambda*mu'+eta*mu'-0.5*dot(Lambda(:),Sigma(:));
H = gaBetheEntropy(Sigma);
lnZ = E+H;