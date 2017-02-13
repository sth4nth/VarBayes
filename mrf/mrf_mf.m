
function [nodeBel, Z, L] = mrf_mf(nodePot, edgePot, B)
% Mean field for MRF (only for undirected graph, not for factor graph)
% TODO:
%   1) verify lower bound Z
%   7) compute in log scale
%   3) compute edge belief

%   2) generalize to factor graph
%   4) EP style
%   5) do not precompute potential value but only store weight (w,b)
%   6) deal with arbitray number of states for x and z

B = logical(B);
epoch = 100;
tol = 1e-4;
[nodeBel, Z] = normalize(nodePot,1);

L = -inf(1,epoch+1);
for t = 1:epoch
    oldNodeBel = nodeBel;
    for i = 1:size(B,2)
        [ej,nj] = fgn(B,i);
        ep = edgePot(:,:,ej);    % edgePot in neighborhood
        np = nodeBel(:,nj);      % nodePot in neighborhood
%         nb = zeros(size(np));
%         for j = 1:length(ej)
%             nb(:,j) = log(ep(:,:,j))*np(:,j);
%         end
%         b = sum(nb,2);
        b = log(reshape(ep,2,[]))*np(:);
        [nodeBel(:,i), Z(i)] = normalize(nodePot(:,i).*exp(b));
    end
    L(t+1) = sum(log(Z));
    if sum(abs(nodeBel(:)-oldNodeBel(:))) < tol; break; end
end
L=L(2:t);

function [ei,ni] = fgn(B,i)
% factor graph neighbor
% ei = neighbor edge index
% ni = neighbor node index
e = B(:,i);                         % edge indcies in the neighborhood
n = B(e,:);                         % node indecis in the neighborhood
n(:,i) = false;                     % exclude self

ei = find(e);
[~,ni] = max(n,[],2);

