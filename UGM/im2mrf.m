function [A, np, ep] = im2mrf(X)
% Convert a image to MRF
A = grid(size(X));
[s,t,e] = find(tril(A));

nStates = 2;
nEdges = numel(e);
nNodes = numel(X);
e = 1:nEdges;
A = sparse([s;t],[t;s],[e(:);e(:)]);

X = X(:);
X = (X-mean(X))/std(X);

np = zeros(nStates,nNodes);
np(1,:) = -1-2.5*X(:);

ep = zeros(nStates,nStates,nEdges);
for i = 1:nEdges
    ps = 1.8 + .3*1/(1+abs(X(s(i))-X(t(i))));
    ep(:,:,e(i)) = [ps, 0; 0, ps];
end


