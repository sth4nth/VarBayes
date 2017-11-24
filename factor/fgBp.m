function [nodeBel, factorBel] = fgBp(B, nodePot, factorPot, epoch)
% Belief propagation on factor graph
%   B: adjacent matrix of bipartite graph\
%   nodePot: node potential
%   factorPot: factor potential
% Written by Mo Chen (sth4nth@gmail.com)
nodePot = cellfun(@(x) exp(-x),nodePot,'UniformOutput',false);    
factorPot = cellfun(@(x) exp(-x),factorPot,'UniformOutput',false);

k = size(nodePot{1},1);
m = size(B,1);
mu = ones(k,2*m)/k;                     % message
for t = 1:epoch
    for i = 1:n
        e = B(:,i);  % neighbor factor indicator vector
        J = B(e,:);  % neighbor node indcator matrix
        J(:,i) = false; % exclude self

        factorIdx = find(e);
        nFactors = numel(factorIdx);

        for k = 1:nFactors
            nodeIdx = find(J(k,:));
            nNodes = numel(nodeIdx);
            fp = factorPot{factorIdx(k)};  
            for j = 1:nNodes
                nb = nodeBel{nodeIdx(j)};
                fp = tvp(fp,nb,j);
            end
            msg(:,k) = fp(:);
        end
        nodeBel{i} = softmax(nodePot{i}+sum(msg,2));
    end
end


