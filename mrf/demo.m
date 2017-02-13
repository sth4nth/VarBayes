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
[nodeBel, Z, L] = mrf_mf(np,ep,B);
[nRows,nCols] = size(X);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field Estimates of Marginals');

[np, ep, B] = im2mrf_ln(X);
[nodeBel_ln, lnZ, L] = mrf_mf_ln(np,ep,B);
nodeBel0 = exp(nodeBel_ln);
[nRows,nCols] = size(X);
subplot(2,2,4);
imagesc(reshape(nodeBel0(2,:),nRows,nCols));
colormap gray

max(abs(nodeBel0(:)-nodeBel(:)))

dl = diff(L);
idx=dl<0;
dl(~idx)=0;
plot(dl);
figure
plot(L)

title('Mean Field Estimates of Marginals');