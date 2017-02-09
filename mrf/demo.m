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