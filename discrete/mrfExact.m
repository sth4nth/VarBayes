function [nodeBel, edgeBel, lnZ] = mrfExact(A, nodePot, edgePot)
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
[s,t,e] = find(triu(A));
m = numel(e);

z = ones(1,n);
nodeBel = zeros(size(nodePot));
edgeBel = zeros(size(edgePot));
Z = 0;
while true
    pot = mrfPot(z,A,nodePot,edgePot);
    expPot = exp(pot);
    % update nodeBel
    for i = 1:n
        nodeBel(z(i),i) = nodeBel(z(i),i)+expPot;
    end
    % update edgeBel
    for l = 1:m
        edgeBel(z(s(l)),z(t(l)),e(l)) = edgeBel(z(s(l)),z(t(l)),e(l))+expPot;
    end
    % update Z
    Z = Z+expPot;
    % next configuration
    for i = 1:n
        z(i) = z(i) + 1;
        if z(i) <= k
            break;
        else
            z(i) = 1;
        end
    end
    % stop when finish all configuration
     if i == n && z(end) == 1
        break;
    end
end
nodeBel = nodeBel/Z;
edgeBel = edgeBel/Z;
lnZ = log(Z);

