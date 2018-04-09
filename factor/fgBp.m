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
t = numel(edge);
edge(:) = 1:t;
B = sparse(nodeIdx,factorIdx,edge);

mu = ones(k,t)/k;                     % message
nu = ones(k,t)/k;                     % message
for t = 1:epoch
    for i = 1:n               % iterate through nodes
        msgIdx = nonzeros(B(:,i));  
        np = nodePot(:,i);
        for l = msgIdx(:)'
            other = setdiff(msgIdx,l);
            nu(:,l) = normalize(np.*prod(mu(:,other),2));
        end
    end
    
    for l = 1:m             % iterate through factors
        msgIdx = nonzeros(B(l,:));
        fp = factorPot{l};
        for j = msgIdx(:)'              
            other = setdiff(msgIdx,j);
            mu(:,j) = normalize(marginalize(fp,nu(:,other)));
        end
    end
end

nodeBel = zeros(k,n);
for i = 1:n               % iterate through nodes
    msgIdx = nonzeros(B(:,i));  
    nb = nodePot(:,i).*prod(mu(:,msgIdx),2);
    nodeBel(:,i) = nb/sum(nb(:));
end

factorBel = cell(1,m);
for l = 1:m
    msgIdx = nonzeros(B(l,:));
    fb = factorPot{l}.*outerprod(nu(:,msgIdx));
    factorBel{l} = fb/sum(fb(:));
end
