function [nodeBel, edgeBel, L] = expProp(A, nodePot, edgePot)
% Expectation propagation for MRF
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   nodeBel: k x n node belief
%   edgeBel: k x k x m edge belief
%   L: variational lower bound (Bethe energy)
% Written by Mo Chen (sth4nth@gmail.com)
nodePot = exp(nodePot);
edgePot = exp(edgePot);

tol = 1e-4;
epoch = 50;
[k,n] = size(nodePot);
m = size(edgePot,3);

[s,t,e] = find(tril(A));
A = sparse([s;t],[t;s],[e;e+m]);       % digraph adjacent matrix, where value is message index
mu = ones(k,2*m)/k;         % message
for iter = 1:epoch
    mu0 = mu;
    for l = 1:m
        i = s(l);
        j = t(l);
        eij = e(l);
        eji = eij+m;
        ep = edgePot(:,:,eij);

        nb = nodePot(:,i).*prod(mu(:,nonzeros(A(:,i))),2);
        mu(:,eij) = normalize(ep*(nb./mu(:,eji)));

        nb = nodePot(:,j).*prod(mu(:,nonzeros(A(:,j))),2);
        mu(:,eji) = normalize(ep*(nb./mu(:,eij)));
    end
    if sum(abs(mu(:)-mu0(:))) < tol; break; end
end

nodeBel = zeros(k,n);
for i = 1:n
    nodeBel(:,i) = nodePot(:,i).*prod(mu(:,nonzeros(A(:,i))),2);
end
nodeBel = normalize(nodeBel,1);

edgeBel = zeros(k,k,m);
for l = 1:m
    eij = e(l);
    eji = eij+m;
    ep = edgePot(:,:,eij);
    nbt = nodeBel(:,t(l))./mu(:,eij);
    nbs = nodeBel(:,s(l))./mu(:,eji);
    eb = (nbt*nbs').*ep;
    edgeBel(:,:,eij) = eb./sum(eb(:));
end