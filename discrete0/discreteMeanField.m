function [nodeBel, edgeBel] = discreteMeanField(A, nodePot, edgePot, epoch)
% Mean field for MRF
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   nodeBel: k x n node belief
%   edgeBel: k x k x m edge belief
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 4
    epoch = 10;
end

[nodeBel,lnZ] = softmax(nodePot,1);    % initialization    
for iter = 1:epoch
    for i = 1:size(nodePot,2)
        [~,j,e] = find(A(i,:));             % neighbors
        [nodeBel(:,i),lnZ(i)] = softmax(nodePot(:,i)+reshape(edgePot(:,:,e),2,[])*reshape(nodeBel(:,j),[],1));
    end
end

[s,t,e] = find(tril(A));
edgeBel = zeros(size(edgePot));
for l = 1:numel(e)
    edgeBel(:,:,e(l)) = nodeBel(:,s(l))*nodeBel(:,t(l))';
end