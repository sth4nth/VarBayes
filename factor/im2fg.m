function [B, np, ep] = im2fg(X)
% Convert a image to a factor graph
A = lattice(size(X));
% A = im2ug(X);
B = ug2fg(A);

[nEdges, nNodes] = size(B);
X = X(:);
X = (X-mean(X))/std(X);
np = cell(nNodes,1);
for n = 1:nNodes
    np{n} = [-1-2.5*X(n);0];
end

ep = cell(nEdges,1);
for e = 1:nEdges
    idx = find(B(e,:));
    ps = 1.8 + .3*1/(1+abs(X(idx(1))-X(idx(2))));
    ep{e} = [ps, 0; 0, ps];
end