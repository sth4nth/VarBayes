function lnZ = gibbsGmrf(x, lambda, L, mu)
% Compute Gibbs free energy of Gaussian MRF


dg = sub2ind([n,n],1:n,1:n);
L(dg) = 0;              % remove diagonal elements



[s,t,e] = find(tril(L));
edgeBel = zeros(size(edgePot));
for l = 1:numel(e)
    edgeBel(:,:,e(l)) = nodeBel(:,s(l))*nodeBel(:,t(l))';
end

edgePot = reshape(edgePot,[],size(edgePot,3));
edgeBel = reshape(edgeBel,[],size(edgeBel,3));
Ex = dot(nodeBel,nodePot,1);
Exy = dot(edgeBel,edgePot,1);
Hx = dot(nodeBel,log(nodeBel),1);
lnZ = -(sum(Ex)+sum(Exy)+sum(Hx));