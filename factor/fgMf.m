function nodeBel = fgMf(B, nodePot, factorPot, epoch)
% Mean field on factor graph. Done
%   B: adjacent matrix of bipartite graph\
%   nodePot: node potential
%   factorPot: factor potential
% Written by Mo Chen (sth4nth@gmail.com)
B = logical(B);
nodeBel = cellfun(@(x) softmax(-x),nodePot,'UniformOutput',false);    % init nodeBel
for t = 1:epoch
    for i = 1:numel(nodePot)
        e = B(:,i);  % neighbor factor indicator vector
        J = B(e,:);  % neighbor node indcator matrix
        J(:,i) = false; % exclude self

        fieldPot = zeros(numel(nodeBel{i}),1);    % sum of incoming message        
        factorIdx = find(e);
        for k = 1:numel(factorIdx)
            fp = factorPot{factorIdx(k)};  
            nodeIdx = find(J(k,:));
            for j = 1:numel(nodeIdx)
                nb = nodeBel{nodeIdx(j)};
                fp = tvp(fp,nb,j);            % tensor vector product
            end
            fieldPot = fieldPot+fp(:);
        end
        nodeBel{i} = softmax(-nodePot{i}-fieldPot);
    end
end




