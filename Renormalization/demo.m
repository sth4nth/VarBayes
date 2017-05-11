clear; close all;
% load letterA.mat;
% X = A;
load letterX.mat
%% Original image
epoch = 50;
J = 1;   % ising parameter
sigma = 1; % noise level
[M, N] = size(X); 
img = double(X);
img = sign(img-mean(img(:)));

figure;
subplot(2,3,1);
imagesc(img);
title('Original image');
axis image;
colormap gray;
%% Noisy image
y = img + sigma*randn(M,N); %y = noisy signal
subplot(2,3,2);
imagesc(y);
title('noisy image');
axis image;
colormap gray;
%% Parameter
z = [1;-1];
y = reshape(y,1,[]);
nodePot = (y-z).^2/(2*sigma^2);
edgePot = -J*(z*z');
h = reshape(0.5*diff(nodePot),M,N);
%% mean field
[p, L] = meanField0(z, A, b);