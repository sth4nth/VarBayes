% clear; close all; clc;
close all; clear;
sigma  = 2; % noise level
load letterA.mat;
img    = A;

[M, N] = size(img); 
img    = double(img);
m      = mean(img(:));
img2   = +1*(img>m) + -1*(img<m); % -1 or +1
y      = img2 + sigma*randn(size(img2)); %y = noisy signal
J    = 1; % coupling strength
CPDs = { gaussCreate(-1, sigma^2) , gaussCreate(+1, sigma^2) };

figure;
imagesc(y);
colorbar;
title('noisy image');
axis('square');
colormap gray;
axis off;


lnp1p = logGauss(y(:)',1,sigma^2);
lnp1m = logGauss(y(:)',-1,sigma^2);
logodds = reshape(lnp1p-lnp1m,M,N);

mu = meanFieldIsingGrid(J, CPDs, @gaussLogprob, y);
mu0 = meanFieldIsingGrid0(logodds, J);
maxdiff(mu0,mu)
figure 
imagesc(mu)
colorbar;
axis('square');
colormap gray;
axis off;
