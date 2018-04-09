function lnZ = fgBethe(B, nodePot, factorPot, nodeBel, factorBel)
% Compute Kikuchi free energy
Ex = dot(nodeBel,nodePot,1);
Ef = cellfun(@(x,y) dot(x(:),y(:)),factorBel,factorPot);
Hx = -dot(nodeBel,log(nodeBel),1);
Hf = cellfun(@(x) -dot(x(:),log(x(:))),factorBel);
d = full(sum(logical(B),1));
lnZ = sum(Ex)+sum(Ef)-sum((d-1).*Hx)+sum(Hf);
