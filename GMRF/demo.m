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
lambda = 1; % noise level lambda = 1/sigma^2
img = img + sqrt(1/lambda)*randn(size(img)); 
subplot(2,3,2);
imagesc(img);
title('Noisy image');
axis image;
colormap gray;
%% Parameters
epoch = 50;
x = img;
n = numel(x);
a = 1;                       % edge weight: L(i,j) = -a
A = a*lattice(size(img));    % adjacent matrix
d = full(sum(A,1));          % node degree: L(i,i) = d(i)
D = sparse(1:n,1:n,d,n,n,n); % degree matrix
L = D-A;                     % Laplacian matrix
d = reshape(d,size(img));
%% Image Gaussian MRF Mean Field
mu = imageGmrfMeanField(img, lambda, d, -a, epoch);

subplot(2,3,3);
imagesc(mu);
title('Image GMRF MF');
axis image;
colormap gray;
%% Gaussian MRF Mean Field
[mu0, LB] = gmrfMeanField(x, lambda, L, epoch);
maxdiff(mu(:),mu0(:))

subplot(2,3,4);
imagesc(mu0);
title('GMRF MF');
axis image;
colormap gray;
%% Gaussian Posterior
Lambda = lambda*speye(n)+L;
mu1 = lambda*(Lambda\x(:));
maxdiff(mu(:),mu1(:))

subplot(2,3,5);
imagesc(reshape(mu1,size(img)));
title('Gauss Posterior');
axis image;
colormap gray;

figure; plot(LB)