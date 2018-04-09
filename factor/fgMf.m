function nodeBel = fgMf(B, nodePot, factorPot, epoch)
% Mean field on factor graph. Done
%   B: adjacent matrix of bipartite graph\
%   nodePot: node potential
%   factorPot: factor potential
% Written by Mo Chen (sth4nth@gmail.com)
B = logical(B);
[k,n] = size(nodePot);
nodeBel = softmax(nodePot,1);    % init nodeBel    
for t = 1:epoch
    for i = 1:n              % iterate through nodes
        f = B(:,i);  % neighbor factor indicator vector
        J = B(f,:);  % neighbor node indcator matrix
        J(:,i) = false; % exclude self

        idx = find(f);                % neighbor factor index
        d = numel(idx);               % number of neighbor factors
        mu = zeros(k,d);              % message from neighbors
        for l = 1:d
            mu(:,l) = marginalize(factorPot{idx(l)},nodeBel(:,J(l,:)));
        end
        nodeBel(:,i) = softmax(+nodePot(:,i)+sum(mu,2));
    end
end