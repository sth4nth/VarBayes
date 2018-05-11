function [label, nodeBel, lnZ] = mrfExact(A, nodePot, edgePot)
% Naive method for exact MRF inference (NP)
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
z = ones(1,n);
energy = -inf;
while true
    pot = mrfPot(z,A,nodePot,edgePot);
    if pot > energy
        label = z;
        energy = pot;
    end
    % next configuration
    for i = 1:n
        z(i) = z(i) + 1;
        if z(i) <= k
            break;
        else
            z(i) = 1;
        end
    end
    
     if i == n && z(end) == 1
        break;
    end
end

function pot = mrfPot(z, A, nodePot,edgePot)
pot = 0;
for i = 1:size(nodePot,2)
   pot = pot+nodePot(z(i),i);
end
[s,t,e] = find(tril(A));
for l = 1:numel(e)
   pot = pot+edgePot(z(s(l)),z(t(l)),e(l));
end
pot = -pot;