function lnZ = betheEnergy(A, nodeBel, edgeBel, nodePot, edgePot)
% Compute Bethe free energy
d = full(sum(A,2));
nb = (d-1).*nodeBel;
H1 = dot(nb(:),log(nodeBel(:)));
E1 = - dot(nodeBel(:),log(nodePot(:)));
H2 = -dot(edgeBel(:),log(edgeBel(:)));
E2 = -dot(edgeBel(:),log(edgePot(:)));
F = (E1+E2) - (H1+H2);
lnZ = -F;