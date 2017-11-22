function [nodeBel, factorBel] = fgBp(B, nodePot, factorPot, epoch)
% Belief propagation on factor graph
%   B: adjacent matrix of bipartite graph\
%   nodePot: node potential
%   factorPot: factor potential
% Written by Mo Chen (sth4nth@gmail.com)
B = logical(B);
nodeBel = cellfun(@softmax,nodePot,'UniformOutput',false);    % init nodeBel
nEdges = size(B,1);
msg = zeros(nStates,2*nEdges)/nStates;
for t = 1:epoch
    for i = 1:n
        e = B(:,i);  % neighbor factor indicator vector
        J = B(e,:);  % neighbor node indcator matrix
        J(:,i) = false; % exclude self

        factorIdx = find(e);
        nFactors = numel(factorIdx);
        msg = zeros(numel(nodeBel{i}),nFactors);    % incoming message        
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


