function lnZ = gaFreeEnergy(eta, Lambda)
% Free energy of Gaussian MRF (normalizer of information form of Gaussian)
%   eta, Lambda: Gausiian MRF parameters
% Written by Mo Chen (sth4nth@gmail.com)
n = numel(eta);
lnZ = dot(eta,eta/Lambda)-logdet(Lambda)+0.5*n*log(2*pi);