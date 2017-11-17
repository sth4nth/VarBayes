function lnZ = gaBethe(eta, Lambda, mu, Sigma)
% Bethe energy of Gaussian MRF, only for stationary solution
% Written by Mo Chen (sth4nth@gmail.com)
E = -0.5*mu*Lambda*mu'+eta*mu'-0.5*(Lambda(:)'*Sigma(:));
H = gaBetheEntropy(Sigma);
lnZ = E+H;