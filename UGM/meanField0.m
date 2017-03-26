function [nodeBel, edgeBel, lnZ, lnZ0] = meanField0(A, nodePot, edgePot)
% Mean field for MRF
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   nodeBel: k x n node belief
%   edgeBel: k x k x m edge belief
%   L: variational lower bound
% Written by Mo Chen (sth4nth@gmail.com)
tol = 1e-4;
epoch = 50;
lnZ = -inf(1,epoch+1);
lnZ0 = -inf(1,epoch+1);

[nodeBel,L] = softmax(-nodePot,1);    % init nodeBel    

for iter = 1:epoch
    for i = 1:numel(L)
        [~,j,e] = find(A(i,:));             % neighbors
        np = nodePot(:,i);
        [lnp ,lnz] = lognormexp(-np-reshape(edgePot(:,:,e),2,[])*reshape(nodeBel(:,j),[],1));
        p = exp(lnp);
        L(i) = -dot(p,lnp+np)+lnz; %
        nodeBel(:,i) = p;
    end
    
    edgeBel = cross(A,nodeBel);
    lnZ0(iter+1) = gibbsEnergy0(nodePot,edgePot,nodeBel,edgeBel);
    lnZ00 =  -dot(nodeBel(:),nodePot(:)+log(nodeBel(:)))-edgeE(A,nodeBel,edgePot);
    lnZ(iter+1) = sum(L)/2;
%     if abs(lnZ(iter+1)-lnZ(iter))/abs(lnZ(iter)) < tol; break; end
end
lnZ = lnZ(2:iter);
lnZ0 = lnZ0(2:iter);

function edgeBel = cross(A,nodeBel)
[s,t,e] = find(tril(A));
k = size(nodeBel,1);
m = numel(e);
edgeBel = zeros(k,k,m);
for l = 1:numel(e)
    edgeBel(:,:,e(l)) = nodeBel(:,s(l))*nodeBel(:,t(l))';
end

function Exy = edgeE(A,nodeBel, edgePot)
[s,t,e] = find(tril(A));
m = numel(e);
Exy = zeros(1,m);
for l = 1:numel(e)
    Exy(l) = nodeBel(:,s(l))'*edgePot(:,:,e(l))*nodeBel(:,t(l));
end
Exy = sum(Exy);