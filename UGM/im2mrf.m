function [A, np, ep] = im2mrf(X)
% Convert a image to MRF
A = grid(size(X));
[s,t,e] = find(tril(A));

nStates = 2;
m = numel(e);
n = numel(X);
e = 1:m;
A = sparse([s;t],[t;s],[e(:);e(:)],n,n);

X = X(:);
X = (X-mean(X))/std(X);

np = zeros(nStates,n);
np(1,:) = -1-2.5*X(:);

ep = zeros(nStates,nStates,m);
for i = 1:m
    ps = 1.8 + .3*1/(1+abs(X(s(i))-X(t(i))));
    ep(:,:,e(i)) = [ps, 0; 0, ps];
end


