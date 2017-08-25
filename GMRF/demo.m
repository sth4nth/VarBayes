%% Original image
clear; close all;
data = load('letterX.mat');
img = double(data.X); 
img = sign(img-mean(img(:)));
figure;
subplot(2,3,1);
imagesc(img);
title('Original image');
axis image;
colormap gray;
%% Noisy image 
[M,N] = size(img); 
lambda = 1; % noise level lambda = 1/sigma^2
x = img + sqrt(1/lambda)*randn(M,N); %y = noisy signal
subplot(2,3,2);
imagesc(x);
title('Noisy image');
axis image;
colormap gray;
%% Parameters
epoch = 50;
Lij = -1;
Lii = 4;

%% Image Gaussian MRF Mean Field
mu = imageGmrfMeanField(x, lambda, Lij, Lii, epoch);

subplot(2,3,3);
imagesc(mu);
title('Image GMRF MF');
axis image;
colormap gray;
%% Gaussian MRF Mean Field
Lij = -lattice(size(x));
Lii = 4*ones(numel(x),1);
mu0 = gmrfMeanField(x, lambda, Lij, Lii, epoch);

maxdiff(mu,mu0)
subplot(2,3,4);
imagesc(mu0);
title('GMRF MF');
axis image;
colormap gray;

%% Gaussian Posterior
n = numel(x);
Lambda = spdiags(Lii+lambda,0,n,n)+Lij;
mu1 = lambda*(Lambda\x(:));
maxdiff(mu(:),mu1)


