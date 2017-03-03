function [nodeBel, edgeBel, L] = mrfMfAsync(A, nodePot, edgePot)
% Mean field for MRF
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   nodeBel: k x n node belief
%   edgeBel: k x k x m edge belief
%   L: 1 x epoch variational lower bound
% Written by Mo Chen (sth4nth@gmail.com)
tol = 1e-4;
epoch = 50;
L = -inf(1,epoch+1);
[nodeBel,lnZ] = softmax(nodePot,1);    % init nodeBel
for iter = 1:epoch
    for i = 1:numel(lnZ)
        [~,j,e] = find(A(i,:));
        [nodeBel(:,i),lnZ(i)] = softmax(nodePot(:,i)+reshape(edgePot(:,:,e),2,[])*reshape(nodeBel(:,j),[],1));
    end
    L(iter+1) = mean(lnZ);
    if abs(L(iter+1)-L(iter)) < tol; break; end
end
L=L(2:iter);

[s,t,e] = find(A);
edgeBel = zeros(size(edgePot));
for i = 1:numel(e)
    edgeBel(:,:,e(i)) = nodeBel(:,s(i))*nodeBel(:,t(i))';
end
