function [nodeBel, factorBel] = fgBp(B, nodePot, factorPot, epoch)
% Belief propagation on factor graph
%   B: adjacent matrix of bipartite graph\
%   nodePot: node potential
%   factorPot: factor potential
% Written by Mo Chen (sth4nth@gmail.com)
nodePot = exp(nodePot); 
factorPot = cellfun(@exp,factorPot,'UniformOutput',false);
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
        nodeBel(:,i) = normalize(prod(mu(:,msgIdx),2).*nodePot(:,i),1);
        nu(:,msgIdx) = nodeBel(:,i)./mu(:,msgIdx);
    end
    
    for k = 1:m             % iterate through factors
        msgIdx = nonzeros(B(k,:));
        fp = factorPot{k};
        for j = msgIdx(:)'              
            other = setdiff(msgIdx,j);
            mu(:,j) = normalize(marginalize(fp,nu(:,other)));
        end
    end
end

factorBel = cell(1,m);
for k = 1:m
    in = nonzeros(B(k,:));
    fb = factorPot{k}.*outerprod(nu(:,in));
    factorBel{k} = fb/sum(fb(:));
end
