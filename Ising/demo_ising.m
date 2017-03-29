% clear; close all; clc;
close all; clear;
load letterA.mat;
[M, N] = size(A); 
sigma  = 2; % noise level
img    = double(A);
img = sign(img-mean(img(:)));
y = img + sigma*randn(M,N); %y = noisy signal
J    = 1; % coupling strength
CPDs = { gaussCreate(-1, sigma^2) , gaussCreate(+1, sigma^2) };


%% image mean field 
lnp1p = logGauss(y(:)',1,sigma^2);
lnp1m = logGauss(y(:)',-1,sigma^2);
logodds = reshape(lnp1p-lnp1m,M,N);

mu = meanFieldIsingGrid(J, CPDs, @gaussLogprob, y);
mu0 = meanFieldIsing(logodds, J);
maxdiff(mu0,mu)
%% graph mean field
A = lattice([M,N]);
% nodePot = ;
% edgePot = ;
[nodeBel, edgeBel, lnZ] = meanField(A, nodePot, edgePot);
%%
figure;
imagesc(y);
colorbar;
title('noisy image');
axis('square');
colormap gray;
axis off;


figure 
imagesc(mu)
colorbar;
axis('square');
colormap gray;
axis off;
