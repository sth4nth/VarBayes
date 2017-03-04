function [nodeBel, edgeBel, L] = expProp(A, nodePot, edgePot)
% Expectation propagation for MRF
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

[s,t] = find(A);
v = 1:2*m;
M = sparse(s,t,v(:));       % digraph adjacent matrix, where value is message index
mu = ones(k,2*m)/k;         % message
for iter = 1:epoch
    mu0 = mu;
    for i = 1:n
        np = nodePot(:,i);
        ne = find(A(i,:));             % neighbors
        for j = ne
            ep = edgePot(:,:,A(i,j));
            out = M(i,j);
            in = M(setdiff(ne,j),i);
            mu(:,out) = normalize(ep*(np.*prod(mu(:,in),2)));
        end
    end
    if sum(abs(mu(:)-mu0(:))) < tol; break; end
end

nodeBel = zeros(k,n);
for i = 1:n
    [~,~,in] = find(M(:,i));
    nodeBel(:,i) = nodePot(:,i).*prod(mu(:,in),2);
end
nodeBel = normalize(nodeBel,1);

edgeBel = zeros(k,k,m);
for e = 1:m
    nodes = find(B(e,:));
    n1 = nodes(1);
    n2 = nodes(2);
    nb1 = nodeBel(:,n1)./mu(:,e+m);
    nb2 = nodeBel(:,n2)./mu(:,e);
    eb = (nb1*nb2').*edgePot(:,:,e);
    edgeBel(:,:,e) = eb./sum(eb(:));
end
