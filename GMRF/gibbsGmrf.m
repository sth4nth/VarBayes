function lnZ = gibbsGmrf(x, lambda, L, mu)
% Compute Gibbs free energy of Gaussian MRF
edgePot = reshape(edgePot,[],size(edgePot,3));
edgeBel = reshape(edgeBel,[],size(edgeBel,3));
Ex = dot(nodeBel,nodePot,1);
Exy = dot(edgeBel,edgePot,1);
Hx = dot(nodeBel,log(nodeBel),1);
lnZ = -(sum(Ex)+sum(Exy)+sum(Hx));