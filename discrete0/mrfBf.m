function [z, lnZ] = mrfBf(A, nodePot, edgePot)
% Brute force method for exact MRF inference
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   nodeBel: k x n node belief
%   edgeBel: k x k x m edge belief
% Written by Mo Chen (sth4nth@gmail.com)
[k,n] = size(nodePot);
lnZ = -inf;
for i = 1:k^n
    z0 = de2bi(i,n,k)+1;      % require communication system toolbox
    lnZ0 = mrfPot(z0,A,nodePot,edgePot);
    if lnZ0 > lnZ
        z = z0;
        lnZ = lnZ0;
    end
end

% TBD
function pot = mrfPot(z, A, nodePot,edgePot)
pot = 0;
for i = 1:size(nodePot,2)
   pot = pot+nodePot(i,z(i));
end
[s,t,e] = find(tril(A));
for l = 1:numel(e)
   pot = pot+edgePot(z(s(l)),z(t(l)),e(l));
end