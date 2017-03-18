function [A, nodePot, edgePot] = im2mrf(X)
% Convert a image to MRF
% nodePot and edgePot are potential energy 
% corresponding mrf is p(x)=exp(sum(nodePot)+sum(edgePot)-lnZ)

A = grid(size(X));
[s,t,e] = find(tril(A));
e(:) = 1:numel(e);
A = sparse([s;t],[t;s],[e;e]);

X = reshape(X,1,[]);
X = (X-mean(X))/std(X);

nodePot = -1-2.5*X;
edgePot = 1.8+0.3./(1+abs(X(s)-X(t)));

nodePot = [1;0]*nodePot;
edgePot = [1;0;0;1]*edgePot;
edgePot = reshape(edgePot,2,2,[]);
