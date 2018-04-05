function [nodeBel, edgeBel, L] = mrfFgBp(A, nodePot, edgePot, epoch)
% Factor graph belief propagation for MRF (treat the MRF as a factor Graph)
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

if nargin < 4
    epoch = 10;
end
[k,n] = size(nodePot);
m = size(edgePot,3);

[s,t,e] = find(tril(A));
A = sparse([s;t],[t;s],[e;e+m]);       % digraph adjacent matrix, where value is message index
mu = ones(k,2*m)/k;                     % message f->n
nu = ones(k,2*m)/k;                                   % message n->f
nodeBel = zeros(k,n);
edgeBel = zeros(k,k,m);
for iter = 1:epoch
    for i = 1:n
        in = nonzeros(A(:,i));                      % incoming message index
        nodeBel(:,i) = normalize(nodePot(:,i).*prod(mu(:,in),2),1);        % product of incoming message
        nu(:,in) = nodeBel(:,i)./mu(:,in);
    end
    
    for l = 1:m
        in = nonzeros(A(l,:));
        ep = edgePot(:,:,l);
        edgeBel(:,:,l) =
        mu(:,in) = 
    end
    L(iter+1) = mrfBethe(A,nodePot,edgePot,nodeBel,edgeBel);
end
