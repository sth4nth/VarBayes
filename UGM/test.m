
clear; close all;
load X.mat
figure
subplot(2,2,1);
imagesc(X);
colormap gray
title('Original X');

[nRows,nCols] = size(X);
X = X + randn(size(X))/2;
subplot(2,2,2);
imagesc(X);
colormap gray
title('Noisy X');

G = grid(size(X));
n = numnodes(G);
m = numedges(G);
k = 2;
[s,t] = findedge(G);

np = zeros(k,n);
ep = zeros(k,k,m);
np(1,:) = -1-2.5*X(:);
for e = 1:m
    ps = 1.8 + .3*1/(1+abs(X(s(e))-X(t(e))));
    ep(:,:,e) = [ps, 0; 0, ps];
end

[nodeBel, L] = mrfMfAsync0(G, np, ep);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field');
% plot(G)

