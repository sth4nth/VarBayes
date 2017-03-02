function [nodeBel, L] = mrfMfAsync0(G, nodePot, edgePot)
% Mean field for MRF (only for undirected graph, not for factor graph)
% TODO:
%   1) EP style
%   2) do not precompute potential value but only store weight (w,b)
%   3) further improve numerical stability to make lnZ monotonically increase
tol = 1e-4;
epoch = 50;
L = -inf(1,epoch+1);
[nodeBel,lnZ] = softmax(nodePot,1);    % init nodeBel
n = numnodes(G);
m = numedges(G);
for t = 1:epoch
    for i = 1:n
        j = neighbors(G,i);
        e = findedge(G,i,j);    % edgePot in neighborhood
        nb = nodeBel(:,j);      % nodeBel in neighborhood
        ep = edgePot(:,:,e);
%         msg = zeros(size(nb));    % incoming message
%         for j = 1:length(ej)
%             msg(:,j) = ep(:,:,j)*nb(:,j);
%         end
%         msgs = sum(msg,2);
        msgs = reshape(ep,2,[])*nb(:);     % sum of incoming message
        [nodeBel(:,i),lnZ(i)] = softmax(nodePot(:,i)+msgs);
    end
    L(t+1) = mean(lnZ);
%     if abs(L(t+1)-L(t)) < tol; break; end
end
L=L(2:t);

edgeBel = zeros(size(edgePot));
[s,t] = findedge(G);
for e = 1:m
    edgeBel(:,:,e) = nodeBel(:,s(e))*nodeBel(:,t(e))';
end


