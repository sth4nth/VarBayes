%% Make noisy X
clear; close all;
load X.mat
[nRows,nCols] = size(X);
X = X + randn(size(X))/2;

figure
subplot(2,2,1);
imagesc(X);
colormap gray
title('Original X');
subplot(2,2,2);
imagesc(X);
colormap gray
title('Noisy X');
%% MF
[np,ep,B] = im2mrf(X);
[nodeBel,L] = mrf_mf(np,ep,B);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field');
%% Parallel MF
[nodeBel0,L0] = mrf_mf_par(np,ep,B);
subplot(2,2,4);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Parallel Mean Field');
%% Lower bound
figure
subplot(2,2,1);
plot(L)
title('Mean Field Lower Bound');
subplot(2,2,2);
plot(L0)
title('Parallel Mean Field Lower Bound');
% 
% dl = diff(L);
% idx=dl<0;
% dl(~idx)=0;
% plot(dl);
% figure
% plot(L)
% 
