function [nodeBel, edgeBel] = mrfBf(A, nodePot, edgePot)
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