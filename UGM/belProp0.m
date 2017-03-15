function [nodeBel, edgeBel, L] = belProp0(A, nodePot, edgePot)
% Belief propagation for MRF
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
M = sparse([s;t],[t;s],[e;e+m]);       % digraph adjacent matrix, where value is message index
mu = ones(k,2*m)/k;         % message

% nodeBel = normalize(nodePot,1);
% edgeBel = reshape(normalize(reshape(edgePot,[],m),1),k,k,[]);

for iter = 1:epoch
    mu0 = mu;
    for i = 1:n
        np = nodePot(:,i);
        out = nonzeros(M(i,:));             % out going edge indices
        in = rd(out,m);          % in comming edge indices        
%         in = nonzeros(M(:,i));
        e = ud(out);
%         e = un(in);
        for j = 1:numel(e)
            ep = edgePot(:,:,e(j));
            
            out_j = out(j);
            in_j = setdiff(in,rd(out_j));
            mu(:,out_j) = normalize(ep*(np.*prod(mu(:,in_j),2)));
        end
    end
    if max(abs(mu(:)-mu0(:))) < tol; break; end
end

nodeBel = zeros(k,n);
for i = 1:n
    nodeBel(:,i) = nodePot(:,i).*prod(mu(:,nonzeros(M(:,i))),2);
end
nodeBel = normalize(nodeBel,1);

edgeBel = zeros(k,k,m);
for l = 1:m
    nbt = nodeBel(:,t(l))./mu(:,M(s(l),t(l)));
    nbs = nodeBel(:,s(l))./mu(:,M(t(l),s(l)));
    eb = (nbt*nbs').*edgePot(:,:,e(l));
    edgeBel(:,:,e(l)) = eb./sum(eb(:));
end


function i = rd(i, m)
% reverse direction edge indeices
i = mod(i+m,2*m);

function i = ud(i, m)
% undirected edge indices
i = mod(i,m);