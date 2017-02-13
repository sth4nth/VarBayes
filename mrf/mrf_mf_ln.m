function [nodeBel, lnZ, L] = mrf_mf_ln(nodePot, edgePot, B)
% Mean field for MRF (only for undirected graph, not for factor graph)
% TODO:
%   1) verify lower bound lnZ
%   7) compute in log scale
%   3) compute edge belief

%   2) generalize to factor graph
%   4) EP style
%   5) do not precompute potential value but only store weight (w,b)
%   6) deal with arbitray number of states for x and z
B = logical(B);
epoch = 100;
tol = 1e-4;
lnZ = logsumexp(nodePot,1);
nodeBel = nodePot-lnZ;
L = -inf(1,epoch+1);
for t = 1:epoch
    oldNodeBel = nodeBel;
    for i = 1:size(B,2)
        [ej,nj] = fgn(B,i);
        ep = edgePot(:,:,ej);    % edgePot in neighborhood
        nb = nodeBel(:,nj);      % nodeBel in neighborhood

        bb = zeros(size(nb));
        for j = 1:length(ej)
            bb(:,j) = ep(:,:,j)*exp(nb(:,j));
        end
        b = sum(bb,2);
%         b = log(reshape(ep,2,[]))*nb(:);
        tb = nodePot(:,i)+b;
        lnZ(i) = logsumexp(tb);
        nodeBel(:,i) = tb-lnZ(i);
    end
    L(t+1) = mean(lnZ);
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
