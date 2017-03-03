function [A, np, ep] = im2mrf(X)
% Convert a image to MRF
nStates = 2;

A = grid(size(X));

[s,t,e] = find(tril(A));
nEdges = numel(e);
nNodes = numel(X);
e = 1:nEdges;
A = sparse([s,t],[t,s],[e,e]);


ep = zeros(nStates,nStates,nEdges);
np = zeros(nStates,nNodes);

X = X(:);
X = (X-mean(X))/std(X);

np(1,:) = -1-2.5*X(:);
np(2,:) = 0;
for i = 1:nEdges
    ps = 1.8 + .3*1/(1+abs(X(s(i))-X(t(i))));
    ep(:,:,e(i)) = [ps, 0; 0, ps];
end


