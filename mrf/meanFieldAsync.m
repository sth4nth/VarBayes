function [nodeBel, L] = meanFieldAsync(B, nodePot, factorPot)
% Mean field on factor graph with async update
B = logical(B);
tol = 1e-4;
epoch = 10;
L = -inf(1,epoch+1);
n = numel(nodePot);
nodeBel = cellmap(@softmax,nodePot);    % init nodeBel
lnZ = zeros(1,n);
for t = 1:epoch
    nodeBel0 = nodeBel;
    for i = 1:n
        e = B(:,i);  % neighbor factor indicator vector
        J = B(e,:);  % neighbor node indcator matrix
        J(:,i) = false; % exclude self

        factorIdx = find(e);
        nFactors = numel(factorIdx);
        mess = zeros(numel(nodeBel{i}),nFactors);    % incoming message        
        for k = 1:nFactors
            nodeIdx = find(J(k,:));
            nNodes = numel(nodeIdx);
            fp = factorPot{factorIdx(k)};  
            for j = 1:nNodes
                nb = nodeBel0{nodeIdx(j)};
                fp = tvp(fp,nb,j);
            end
            mess(:,k) = fp(:);
        end
        [nodeBel{i},lnZ(i)] = softmax(nodePot{i}+sum(mess,2));
    end
    L(t+1) = mean(lnZ);
    if abs(L(t+1)-L(t)) < tol; break; end    
end
L=L(2:t);



