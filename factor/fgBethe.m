function lnZ = fgBethe(B, nodePot, factorPot, nodeBel, factorBel)
% Compute Kikuchi free energy
Ex = dot(nodeBel,nodePot,1);
Hx = -dot(nodeBel,log(nodeBel),1);
Exy = cellfun(@(x,y) dot(x(:),y(:)),factorBel,factorPot);
Hxy = cellfun(@(x,y) -dot(x(:),log(x(:))),factorBel,factorBel);
d = full(sum(logical(B),1));
lnZ = -sum(Ex)-sum(Exy)-sum((d-1).*Hx)+sum(Hxy);
