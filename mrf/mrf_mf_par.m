function [nodeBel, L] = mrf_mf_par(nodePot, edgePot, B)
% Parallel mean field for MRF (only for undirected graph, not for factor graph)
% parallel update does not guarentee convergence, the lower bound of the final 
% solution may oscillate a little below the optimal value
% TODO:
%   1) iterate through edge instead of node (EP style)
B = logical(B);
tol = 1e-4;
epoch = 10;
L = -inf(1,epoch+1);
[nodeBel,lnZ] = softmax(nodePot,1);    % init nodeBel
% [k,n] = size(nodePot);
% nodeBel = ones(k,n)/k;                      
% lnZ = zeros(1,n);
for t = 1:epoch
    nodeBel0 = nodeBel;
    for i = 1:size(B,2)
        [ej,nj] = fgn(B,i);
        ep = edgePot(:,:,ej);    % edgePot in neighborhood
        nb = nodeBel0(:,nj);      % nodeBel in neighborhood
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
L=L(2:t-1);

function [ei,ni] = fgn(B,i)
% factor graph neighbor
% ei = neighbor edge index
% ni = neighbor node index
e = B(:,i);                         % edge indcies in the neighborhood
n = B(e,:);                         % node indecis in the neighborhood
n(:,i) = false;                     % exclude self

ei = find(e);
[~,ni] = max(n,[],2);
