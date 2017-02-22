%% Make noisy X
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
%%
[np,ep,B] = im2fg(X);
[nb,L] = fg_mf(np,ep,B);
nodeBel = reshape(cell2mat(nb),2,[]);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field');
%%
[np,ep,B] = im2mrf(X);
[nodeBel0,L0] = mrf_mf(np,ep,B);
subplot(2,2,4);
imagesc(reshape(nodeBel0(2,:),nRows,nCols));
colormap gray
title('Mean Field');
