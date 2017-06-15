function [nodeBel, edgeBel] = renMeanField(A, nodePot, edgePot, epoch)
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

[k,n] = size(nodePot);

qxz = zeros(k,k,n);
qz = zeros(k,n);
[nodeBel,L] = softmax(-nodePot,1);    % init nodeBel    

for i = 1:n
    nodeBel(:,i) = qz(:,i)*qxz(:,:,i);
end

for iter = 1:epoch
    for i = 1:numel(L)
        [~,j,e] = find(A(i,:));             % neighbors
        nodeBel(:,i) = softmax(-nodePot(:,i)-reshape(edgePot(:,:,e),2,[])*reshape(nodeBel(:,j),[],1));
    end
    if max(abs(nodeBel(:)-nodeBel0(:))) < tol; break; end
end

[s,t,e] = find(tril(A));
edgeBel = zeros(size(edgePot));
for l = 1:numel(e)
    edgeBel(:,:,e(l)) = nodeBel(:,s(l))*nodeBel(:,t(l))';
end