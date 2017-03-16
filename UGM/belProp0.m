function [nodeBel, edgeBel, L] = belProp0(A, nodePot, edgePot)
% Renormalized Belief propagation for MRF
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   nodeBel: k x n node belief
%   edgeBel: k x k x m edge belief
%   L: variational lower bound (Bethe energy)
% Written by Mo Chen (sth4nth@gmail.com)
tol = 1e-4;
epoch = 50;
[k,n] = size(nodePot);
m = size(edgePot,3);

[s,t,e] = find(tril(A));
A = sparse([s;t],[t;s],[e;e+m]);       % digraph adjacent matrix, where value is message index
mu = ones(k,2*m)/k;         % message
nodeBel = normalize(nodePot,1);
for iter = 1:epoch
    mu0 = mu;
    for i = 1:n
        [ne,~,in] = find(A(:,i));
        for l = 1:numel(ne)
            j = ne(l);
            eji = in(l);
            eij = rd(eji,m);

            ep = edgePot(:,:,ud(eji,m));
            nodeBel(:,j) = nodeBel(:,j)./mu(:,eij);
            mu(:,eij) = normalize(ep*(nodeBel(:,i)./mu(:,eji)));
            nodeBel(:,j) = normalize(nodeBel(:,j).*mu(:,eij));
        end
    end
    if max(abs(mu(:)-mu0(:))) < tol; break; end
end

edgeBel = zeros(k,k,m);
for l = 1:m
    nbt = nodeBel(:,t(l))./mu(:,A(s(l),t(l)));
    nbs = nodeBel(:,s(l))./mu(:,A(t(l),s(l)));
    eb = (nbt*nbs').*edgePot(:,:,e(l));
    edgeBel(:,:,e(l)) = eb./sum(eb(:));
end

function i = rd(i, m)
% reverse direction edge index
i = mod(i+m-1,2*m)+1;

function i = ud(i, m)
% undirected edge index
i = mod(i-1,m)+1;