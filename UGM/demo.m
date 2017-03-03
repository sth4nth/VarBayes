
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
[A,np,ep] = im2mrf(X);
[nodeBel, edgeBel, L] = mrfMfAsync(A, np, ep);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field');
%%
[nodeBel, edgeBel, L] = mrfMfSync(A, np, ep);
subplot(2,2,4);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field Parallel');