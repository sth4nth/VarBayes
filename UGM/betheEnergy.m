function lnZ = betheEnergy(A, nodeBel, edgeBel, nodePot, edgePot)
% Compute Bethe free energy
Ex = dot(nodeBel(:),log(nodePot(:)));
Exy = dot(edgeBel(:),log(edgePot(:)));

d = full(sum(logical(A),1));
nb = (d-1).*nodeBel;
Hx = -dot(nb(:),log(nodeBel(:)));
Hxy = -dot(edgeBel(:),log(edgeBel(:)));

lnZ = (Ex+Exy)-(Hx-Hxy);
