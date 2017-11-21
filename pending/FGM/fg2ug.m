function A = fg2ug(B)
% convert adjacent matrix of bipartite factor graph to adjacent matrix of undirected graph
% Input:
%   B: m x n adjacent matrix of bipartite factor graph 
%       where m and n are # of edges and nodes
% Output:
%   A: n x n adjacent matrix of undirected graph
% Written by Mo Chen (sth4nth@gmail.com)
A = B'*B;
A = A-diag(diag(A));