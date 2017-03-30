% clear; close all; clc;
close all; clear;
load letterA.mat;
% load letterX.mat
% A = X;
[M, N] = size(A); 
K = 2;
sigma  = 2; % noise level
img    = double(A);
img = sign(img-mean(img(:)));
y = img + sigma*randn(M,N); %y = noisy signal
y = reshape(y,1,[]);
z = [1;-1];
%% image mean field 
% nodePot = (y-z).^2/(2*sigma^2)-log(sigma);
nodePot = (y-z).^2/(2*sigma^2);
logodds = reshape(diff(nodePot),M,N);
J = 1; % coupling strength
mu = meanFieldIsing(logodds, J);
%% graph mean field
A = lattice([M,N]);
nEdge = nnz(tril(A));
edgePot = repmat(J*(z*z'),[1, 1, nEdge]);
% [nodeBel, lnZ] = meanField(A, nodePot, edgePot);
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
