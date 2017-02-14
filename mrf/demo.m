%% Make noisy X
clear; close all;
load X.mat
[nRows,nCols] = size(X);
figure
subplot(2,2,1);
imagesc(X);
colormap gray
title('Original X');

X = X + randn(size(X))/2;
subplot(2,2,2);
imagesc(X);
colormap gray
title('Noisy X');
%% MF
[np,ep,B] = im2mrf(X);
[nodeBel,lnZ,L] = mrf_mf(np,ep,B);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field');

% 
% dl = diff(L);
% idx=dl<0;
% dl(~idx)=0;
% plot(dl);
% figure
% plot(L)
% 
figure
plot(L)