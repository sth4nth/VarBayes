function B = ug2fg(A)
% convert adjacent matrix of undirected graph to adjacent matrix of
% bipartite factor graph
% Input:
%   A: n x n adjacent matrix of undirected graph
% Output:
%   B: m x n adjacent matrix of bipartite factor graph 
%       where m and n are # of edges and nodes
% Written by Mo Chen (sth4nth@gmail.com)
[s,t,w] = find(tril(A));
m = numel(w);
n = size(A,1);
idx = 1:m;
node = [s;t];
edge = [idx(:);idx(:)];
v = sqrt(w(:));
v = [v;v];
B = sparse(edge,node,v,m,n);
