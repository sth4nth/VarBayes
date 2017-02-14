function [nodeBel, L] = mrf_mf(nodePot, edgePot, B)
% Mean field for MRF (only for undirected graph, not for factor graph)
% TODO:
%   1) compute edge belief
%   2) generalize to factor graph
%   3) EP style
%   4) do not precompute potential value but only store weight (w,b)
%   5) deal with arbitray number of states for x and z
%   6) further improve numerical stability to make lnZ monotonically increase
B = logical(B);
tol = 1e-4;
epoch = 50;
L = -inf(1,epoch+1);
[nodeBel,lnZ] = softmax(nodePot,1);    % init nodeBel
for t = 1:epoch
    for i = 1:size(B,2)
        [ej,nj] = fgn(B,i);
        ep = edgePot(:,:,ej);    % edgePot in neighborhood
        nb = nodeBel(:,nj);      % nodeBel in neighborhood
%         m = zeros(size(nb));    % incoming message
%         for j = 1:length(ej)
%             m(:,j) = ep(:,:,j)*nb(:,j);
%         end
%         sm = sum(m,2);
        sm = reshape(ep,2,[])*nb(:);     % sum of incoming message
        [nodeBel(:,i),lnZ(i)] = softmax(nodePot(:,i)+sm);
    end
    L(t+1) = mean(lnZ);
    if abs(L(t+1)-L(t)) < tol; break; end
end
L=L(2:t);

edgeBel = zeros(size(edgePot));
for e = 1:size(B,1)
    ni = find(B(e,:));
    edgeBel(:,:,e) = nodeBel(:,ni(1))*nodeBel(:,ni(2))';
end

function [ei,ni] = fgn(B,i)
% factor graph neighbor
% ei = neighbor edge index
% ni = neighbor node index
e = B(:,i);                         % edge indcies in the neighborhood
n = B(e,:);                         % node indecis in the neighborhood
n(:,i) = false;                     % exclude self

ei = find(e);
[~,ni] = max(n,[],2);
