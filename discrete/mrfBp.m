function [nodeBel, edgeBel, L] = mrfBp(A, nodePot, edgePot, epoch)
% Undirected graph belief propagation for MRF
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
if nargin < 4
    epoch = 10;
end
nodePot = exp(nodePot);  
edgePot = exp(edgePot);
[k,n] = size(nodePot);
m = size(edgePot,3);

[s,t,e] = find(tril(A));
A = sparse([s;t],[t;s],[e;e+m]);       % digraph adjacent matrix, where value is message index
mu = ones(k,2*m)/k;                     % message factor to node
nu = ones(k,2*m)/k;                     % message node to factor

nodeBel = zeros(k,n);
edgeBel = zeros(k,k,m);
L = -inf(1,epoch+1);
for iter = 1:epoch
    for i = 1:n
        in = nonzeros(A(:,i));                      % incoming message index
        nb = nodePot(:,i).*prod(mu(:,in),2);                       % product of incoming message
        for l = in'
            ep = edgePot(:,:,ud(l,m));
            mu(:,rd(l,m)) = normalize(ep*(nb./mu(:,l)));
        end
        nodeBel(:,i) = nb/sum(nb);
    end
    
    for l = 1:m
        eij = e(l);
        eji = eij+m;
        ep = edgePot(:,:,eij);
        nbt = nodeBel(:,t(l))./mu(:,eij);
        nbs = nodeBel(:,s(l))./mu(:,eji);
        eb = (nbt*nbs').*ep;
        edgeBel(:,:,eij) = eb./sum(eb(:));
    end
    L(iter+1) = mrfBethe(A,nodePot,edgePot,nodeBel,edgeBel);
end
L = L(1,2:iter+1);

function i = rd(i, m)
% reverse direction edge index
i = mod(i+m-1,2*m)+1;

function i = ud(i, m)
% undirected edge index
i = mod(i-1,m)+1;