function [nodeBel, L] = mrf_mf(B, nodePot, edgePot)
% Mean field for MRF
% Although this function take the bipartite factor graph adjacent matrix as
% input, it works only for pairwise MRF for now. Need to be modified for
% general factor graph mean field.
B = logical(B);
epoch = 100;
tol = 1e-4;
n = size(B,2);
L = zeros(1,n);
nodeBel = normalize(nodePot,2);
for t = 1:epoch
    for i = 1:n
        l = B(:,i);                         % edge indcies in the neighborhood
        j = B(l,:);                         % node indecis in the neighborhood
        j(:,i) = false;                     % exclude self

        ll = find(l);
        [~,jj] = max(j,[],2);
        
        ep = edgePot(:,:,ll);
        nb = nodePot(:,jj);
        
        bb = zeros(size(nb));
        for e = 1:sum(l)
            bb(:,e) = log(ep(:,:,e))*nb(:,e);
        end
        b = sum(bb,2);
        
        [nodeBel(:,i), L(i)] = normalize(nodePot(:,i).*exp(b));
    end
    if sum(L) < tol; break; end;
end