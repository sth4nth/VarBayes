function lnZ = betheEnergy0(A, nodeBel, edgeBel, nodePot, edgePot)
% Compute Bethe free energy
d = full(sum(logical(A),1));
Ex = nodeBel.*log(nodePot);
Exy = edgeBel.*log(edgePot);
Hx = -(d-1).*nodeBel.*log(nodeBel);
Hxy = -edgeBel.*log(edgeBel);
lnZ = sum(Ex(:))+sum(Exy(:))-sum(Hx(:))+sum(Hxy(:));

