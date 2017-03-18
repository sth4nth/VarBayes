function [A, np, ep] = im2mrf(X)
% Convert a image to MRF

A = grid(size(X));
[s,t,e] = find(tril(A));
e(:) = 1:numel(e);
A = sparse([s;t],[t;s],[e;e]);

X = reshape(X,1,[]);
X = (X-mean(X))/std(X);

np = -1-2.5*X;
ep = 1.8+0.3./(1+abs(X(s)-X(t)));

np = [1;0]*np;
ep = [1;0;0;1]*ep;
ep = reshape(ep,2,2,[]);
