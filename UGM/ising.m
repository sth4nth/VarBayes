function [A, nodePot, edgePot = ising( X, t )
% Ising model
% Input: 
%   X: input observation
%   t: temprature
% Output:
%   A: n x n adjacent matrix of undirected graph, where value is edge index
%   nodePot: 2 x n node potential
%   edgePot: 2 x 2 x m edge potential
% Written by Mo Chen (sth4nth@gmail.com)

A = grid(size(X));

