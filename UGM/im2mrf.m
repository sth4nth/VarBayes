function [B,np, ep] = im2mrf(X)
% Convert a image to MRF
nStates = 2;
A = im2ug(X);
B = ug2fg(A);

[s,t,w] = find(tril(A));
G = graph(s,t,w);
n = numnodes(G);
m = numedges(G);
k = 2;
[s,t] = findedge(G);

npp = zeros(k,n);
epp = zeros(k,k,m);
npp(1,:) = -1-2.5*X(:);
for e = 1:m
    ps = 1.8 + .3*1/(1+abs(X(s(e))-X(t(e))));
    epp(:,:,e) = [ps, 0; 0, ps];
end

[nEdges, nNodes] = size(B);
ep = zeros(nStates,nStates,nEdges);
np = zeros(nStates,nNodes);

X = X(:);
X = (X-mean(X))/std(X);

np(1,:) = -1-2.5*X(:);
np(2,:) = 0;
for e = 1:nEdges
    idx = find(B(e,:));
    ps = 1.8 + .3*1/(1+abs(X(idx(1))-X(idx(2))));
    ep(:,:,e) = [ps, 0; 0, ps];
end
pause


