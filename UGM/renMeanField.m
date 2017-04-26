function [nodeBel, edgeBel, lnZ] = renMeanField(A, nodePot, edgePot)
% Mean field for MRF
% Assuming egdePot is symmetric
% Input: 
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: k x n node potential
%   edgePot: k x k x m edge potential
% Output:
%   nodeBel: k x n node belief
%   edgeBel: k x k x m edge belief
%   L: variational lower bound
% Written by Mo Chen (sth4nth@gmail.com)
epoch = 50;
tol = 1e-4;

[k,n] = size(nodePot);
W = zeros(2,k);

for iter = 1:epoch
    for i = 1:n
    end
end
