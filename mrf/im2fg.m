function [np, ep, B] = im2fg(X)
% Convert a image to MRF
A = im2ug(X);
B = ug2fg(A);

[nEdges, nNodes] = size(B);
Xstd = UGM_standardizeCols(reshape(X,[1 1 nNodes]),1);

np = cell(nNodes,1);
for n = 1:nNodes
    np{n} = [-1-2.5*Xstd(n);0];
end

ep = cell(nEdges,1);
for e = 1:nEdges
    idx = find(B(e,:));
    ps = 1.8 + .3*1/(1+abs(Xstd(idx(1))-Xstd(idx(2))));
    ep{e} = [ps, 0; 0, ps];
end