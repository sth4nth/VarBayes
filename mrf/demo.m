%% Make noisy X
clear; close all;
load X.mat
subplot(2,2,1);
imagesc(X);
colormap gray
title('Original X');

X = X + randn(size(X))/2;
subplot(2,2,2);
imagesc(X);
colormap gray
title('Noisy X');

[np, ep, B] = im2mrf(X);
[nodeBel, lnZ, L] = mrf_mf(np,ep,B);
[nRows,nCols] = size(X);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field Estimates of Marginals');