function [nodeBel, factorBel] = fgBp(B, nodePot, factorPot, epoch)
% Belief propagation on factor graph
%   B: adjacent matrix of bipartite graph\
%   nodePot: node potential
%   factorPot: factor potential
% Written by Mo Chen (sth4nth@gmail.com)
nodePot = exp(-nodePot); 
factorPot = cellfun(@(x) exp(-x),factorPot,'UniformOutput',false);
[m,n] = size(B);
k = size(nodePot,1);

[nodeIdx,factorIdx,edge] = find(B);
nEdge = numel(edge);
edge(:) = 1:nEdge;
B = sparse(nodeIdx,factorIdx,edge);

mu = ones(k,nEdge)/k;                     % message
nu = ones(k,nEdge)/k;                     % message

nodeBel = zeros(k,n);
for t = 1:epoch
    for i = 1:n               % iterate through nodes
        msgIdx = nonzeros(B(:,i));  
        nodeBel(:,i) = prod(mu(:,msgIdx),2).*nodePot(:,i);
        nu(:,msgIdx) = nodeBel(:,i)./mu(:,msgIdx);
    end
    
    for k = 1:m             % iterate through factors
        msgIdx = nonzeros(B(k,:));
        fp = factorPot{k};
        for j = msgIdx
            other = setdiff(msgIdx,j);
            mu(:,j) = marginalize(fp,nu(:,other));
        end
    end
end

