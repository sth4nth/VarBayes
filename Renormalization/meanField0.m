function [p, L] = meanField0(x, A, b)
% Parametric (fixed formed) Mean field for MRF. 
% This function working on parameter of distribution instead of directly
% working on probability.
% Assuming egdePot is symmetric
% Input: 
%   x: k x 1 possible value
%   A: n x n edge weight of an undirected graph
%   b: 1 x n node weight of an undirected graph
% Output:
%   p: k x n probability
%   L: variational lower bound
% Written by Mo Chen (sth4nth@gmail.com)
epoch = 50;
tol = 1e-4;
lnZ = -inf(1,epoch+1);
h = b;
for iter = 1:epoch
    for i = 1:numel(L)
        [~,j,e] = find(A(i,:));             % neighbors
        np = nodePot(:,i);
        [lnp ,lnz] = lognormexp(-np-reshape(edgePot(:,:,e),2,[])*reshape(nodeBel(:,j),[],1));
        p = exp(lnp);
        L(i) = -dot(p,lnp+np)+lnz; %
        nodeBel(:,i) = p;
    end
    lnZ(iter+1) = sum(L)/2;
%     if abs(lnZ(iter+1)-lnZ(iter))/abs(lnZ(iter)) < tol; break; end
end
lnZ = lnZ(2:iter);

[s,t,e] = find(tril(A));
edgeBel = zeros(size(edgePot));
for l = 1:numel(e)
    edgeBel(:,:,e(l)) = nodeBel(:,s(l))*nodeBel(:,t(l))';
end