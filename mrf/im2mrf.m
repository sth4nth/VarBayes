function [np, ep, B] = im2mrf(X)
nStates = 2;

A = im2ug(X);
B = ug2fg(A);

[nEdges, nNodes] = size(B);

ep = zeros(nStates,nStates,nEdges);
np = zeros(nStates,nNodes);

Xstd = UGM_standardizeCols(reshape(X,[1 1 nNodes]),1);
% np(1,:) = exp(-1-2.5*Xstd(:));
% np(2,:) = 1;
np(1,:) = -1-2.5*Xstd(:);
np(2,:) = 0;
for e = 1:nEdges
    idx = find(B(e,:));
%     ps = exp(1.8 + .3*1/(1+abs(Xstd(idx(1))-Xstd(idx(2)))));
%     ep(:,:,e) = [ps 1;1 ps];
    ps = 1.8 + .3*1/(1+abs(Xstd(idx(1))-Xstd(idx(2))));
    ep(:,:,e) = [ps, 0; 0, ps];
end