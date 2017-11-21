function lnZ = gaEnergy(eta, Lambda)
% Free energy of Gaussian MRF (normalizer of information form of Gaussian)
% Written by Mo Chen (sth4nth@gmail.com)
n = numel(eta);
lnZ = eta*(Lambda\eta')-logdet(Lambda)+0.5*n*log(2*pi);