function lnZ = gibbsEnergy(mu, Lii)
% Compute Gibbs free energy of Gaussian MRF

Ex = dot(nodeBel,nodePot,1);
Exy = dot(edgeBel,edgePot,1);
Hx = -dot(nodeBel,log(nodeBel),1);
lnZ = -sum(Ex)-sum(Exy)+sum(Hx);