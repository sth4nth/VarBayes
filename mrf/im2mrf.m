function [nodePot, edgePot, B] = im2mrf(im)
A = im2ug(im);
B = ug2fg(A);

nodePot = zeros(nNodes,nStates);
nodePot(1,:) = exp(-1-2.5*Xstd(:));
nodePot(2,:) = 1;         % exp(0*z*w)=1

edgePot = zeros(n,n,m);
for e = 1:size(B,2)
    ind B(:,e);
    pot = exp(1.8 + .3*1/(1+abs(Xstd(n1)-Xstd(n2))));
    edgePot(:,:,e) = [pot 1;1 pot];  % exp(0*0*w)=1; exp(1*1*w)=pot_same
end