function [nodeBel, edgeBel, L] = meanField(A, nodePot, edgePot, epoch)
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
tol = 0;
if nargin < 4
    epoch = 10;
    tol = 1e-4;
end
L = -inf(1,epoch+1);
[nodeBel,lnZ] = softmax(-nodePot,1);    % init nodeBel    
for iter = 1:epoch
    for i = 1:numel(lnZ)
        [~,j,e] = find(A(i,:));             % neighbors
        [nodeBel(:,i) ,lnZ(i)] = softmax(-nodePot(:,i)-reshape(edgePot(:,:,e),2,[])*reshape(nodeBel(:,j),[],1));
    end
    H = -dot(nodeBel,log(nodeBel),1);
    E = dot(nodeBel,nodePot,1);
    L(iter+1) = sum(lnZ+H-E)/2;
    if abs(L(iter+1)-L(iter))/abs(L(iter)) < tol; break; end
end
L = L(2:iter);

[s,t,e] = find(tril(A));
edgeBel = zeros(size(edgePot));
for l = 1:numel(e)
    edgeBel(:,:,e(l)) = nodeBel(:,s(l))*nodeBel(:,t(l))';
end
% L0 = sum(lnZ)+dot(edgeBel(:),edgePot(:));
% maxdiff(L0,L(end))