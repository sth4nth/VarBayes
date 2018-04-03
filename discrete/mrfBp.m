function [nodeBel, edgeBel] = mrfBp(A, nodePot, edgePot, epoch)
% Belief propagation for MRF, calculation in log scale
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
[k,n] = size(nodePot);
m = size(edgePot,3);

[s,t,e] = find(tril(A));
A = sparse([s;t],[t;s],[e;e+m]);       % digraph adjacent matrix, where value is message index
mu = zeros(k,2*m)-log(k);              % initialize message
for iter = 1:epoch
    for i = 1:n
        in = nonzeros(A(:,i));                      % incoming message index
        nb = nodePot(:,i)+sum(mu(:,in),2);                       % product of incoming message
        for l = in'
            ep = edgePot(:,:,ud(l,m));
            mut = logsumexp(ep+(nb-mu(:,l)),1);
            mu(:,rd(l,m)) = mut-logsumexp(mut);
        end
    end
end

nodeBel = zeros(k,n);
for i = 1:n
    nb = nodePot(:,i)+sum(mu(:,nonzeros(A(:,i))),2);
    nodeBel(:,i) = softmax(nb);
end

edgeBel = zeros(k,k,m);
for l = 1:m
    eij = e(l);
    eji = eij+m;
    ep = edgePot(:,:,eij);
    nbt = nodeBel(:,t(l))-mu(:,eij);
    nbs = nodeBel(:,s(l))-mu(:,eji);
    eb = (nbt+nbs')+ep;
    edgeBel(:,:,eij) = softmax(eb);
end


function i = rd(i, m)
% reverse direction edge index
i = mod(i+m-1,2*m)+1;

function i = ud(i, m)
% undirected edge index
i = mod(i-1,m)+1;