clear; close all;
% load letterA.mat;
% X = A;
load letterX.mat
%% Original image
epoch = 50;
J = 1;   % ising parameter
sigma = 1; % noise level

img = double(X);
img = sign(img-mean(img(:)));

figure;
subplot(2,3,1);
imagesc(img);
title('Original image');
axis image;
colormap gray;
%% Noisy image
y = img + sigma*randn(size(img)); %y = noisy signal
subplot(2,3,2);
imagesc(y);
title('Noisy image');
axis image;
colormap gray;



h = reshape(0.5*diff(nodePot),M,N);
