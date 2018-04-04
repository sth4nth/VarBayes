% Done!
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
x = img + sigma*randn(size(img)); % noisy signal
subplot(2,3,2);
imagesc(x);
title('Noisy image');
axis image;
colormap gray;
%% Construct MRF data
[A, nodePot, edgePot] = mrfIsGa(x, sigma, J);
%% Mean Field
[nodeBel, edgeBel, L] = mrfMf(A, nodePot, edgePot, epoch);

L0 = mrfGibbs(A, nodePot, edgePot, nodeBel);
L1 = mrfBethe(A, nodePot, edgePot, nodeBel, edgeBel);
maxdiff(L0, L(end))
maxdiff(L0, L1)

subplot(2,3,4);
imagesc(reshape(nodeBel(1,:),size(img)));
title('Mean Field');
axis image;
colormap gray;
%% Undirected Graph Belief Propagation
[nodeBel, edgeBel] = mrfUgBp(A, nodePot, edgePot, epoch);

subplot(2,3,5);
imagesc(reshape(nodeBel(1,:),size(img)));
title('UG BP');
axis image;
colormap gray;
%% Factor Graph Belief Propagation
[nodeBel, edgeBel] = mrfFgBp(A, nodePot, edgePot, epoch);

subplot(2,3,6);
imagesc(reshape(nodeBel(1,:),size(img)));
title('FG BP');
axis image;
colormap gray;
%% Gibbs Sampling
% z = mrfGs(A, nodePot, edgePot, epoch);
% 
% subplot(2,3,6);
% imagesc(reshape(z(1,:),size(img)));
% title('Gibbs Sampling');
% axis image;
% colormap gray;
%% Exact: TBD
% z = mrfExact(A, nodePot, edgePot);
% 
% subplot(2,3,3);
% imagesc(reshape(z(1,:),size(img)));
% title('Exact');
% axis image;
% colormap gray;