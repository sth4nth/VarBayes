function [nodeBel, L] = fgMf(B, nodePot, factorPot, epoch)
% Mean field on factor graph. Done
%   B: adjacent matrix of bipartite graph\
%   nodePot: node potential
%   factorPot: factor potential
% Written by Mo Chen (sth4nth@gmail.com)
B = logical(B);
tol = 1e-4;
L = -inf(1,epoch+1);
n = numel(nodePot);
nodeBel = cellfun(@softmax,nodePot,'UniformOutput',false);    % init nodeBel
lnZ = zeros(1,n);
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
                fp = tvp(fp,nb,j);            % tensor vector product
            end
            msg(:,k) = fp(:);
        end
        [nodeBel{i},lnZ(i)] = softmax(nodePot{i}+sum(msg,2));
    end
    L(t+1) = mean(lnZ);
    if abs(L(t+1)-L(t)) < tol; break; end    
end
L=L(2:t);



