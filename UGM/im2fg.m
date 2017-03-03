function [B, np, ep] = im2fg(X)
% Convert a image to MRF
nStates = 2;
A = grid(size(X));
B = ug2fg(A);

[nEdges, nNodes] = size(B);
ep = zeros(nStates,nStates,nEdges);
np = zeros(nStates,nNodes);

X = X(:);
X = (X-mean(X))/std(X);

np(1,:) = -1-2.5*X(:);
for e = 1:nEdges
    idx = find(B(e,:));
    ps = 1.8 + .3*1/(1+abs(X(idx(1))-X(idx(2))));
    ep(:,:,e) = [ps, 0; 0, ps];
end

