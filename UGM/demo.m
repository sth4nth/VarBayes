
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
%% Mean Field
[A,np,ep] = im2mrf(X);
[nodeBel, edgeBel, L] = mrfMfAsync(A, np, ep);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field');
%% Belief Propagation
[B,np,ep] = im2fg(X);
[nodeBel, edgeBel] = mrfLbpAsync(B, exp(np), exp(ep));
subplot(2,2,4);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field Parallel');