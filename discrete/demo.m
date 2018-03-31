% Done!
clear; close all;
% load letterA.mat;
% X = A;
load letterX.mat
% X = imresize(X,[4,4]);
%% Original image
epoch = 20;
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
[nodeBel, edgeBel] = mrfMf(A, nodePot, edgePot, epoch);

L0 = mrfGibbs(nodePot, edgePot, nodeBel, edgeBel);
L1 = mrfBethe(A, nodePot, edgePot, nodeBel, edgeBel);
% maxdiff(L0, L(end))
maxdiff(L0, L1)

subplot(2,3,3);
imagesc(reshape(nodeBel(1,:),size(img)));
title('MF');
axis image;
colormap gray;
%% Belief Propagation
[nodeBel,edgeBel] = mrfBp(A, nodePot, edgePot, epoch);

subplot(2,3,4);
imagesc(reshape(nodeBel(1,:),size(img)));
title('BP');
axis image;
colormap gray;
%% Expectation Propagation
% [nodeBel,edgeBel] = expProp(A, nodePot, edgePot, epoch);
% 
% lnZ0 = betheEnergy(A, nodePot, edgePot, nodeBel, edgeBel);
% 
% [nodeBel0,edgeBel0] = expProp0(A, nodePot, edgePot, epoch);
% maxdiff(nodeBel,nodeBel0)
% maxdiff(edgeBel,edgeBel0)
% 
% subplot(2,3,5);
% imagesc(reshape(nodeBel(1,:),size(img)));
% title('EP');
% axis image;
% colormap gray;
%% EP-BP
% [nodeBel,edgeBel] = expBelProp(A, nodePot, edgePot, epoch);
% 
% [nodeBel0,edgeBel0] = expBelProp0(A, nodePot, edgePot, epoch);
% maxdiff(nodeBel,nodeBel0)
% maxdiff(edgeBel,edgeBel0)
% 
% subplot(2,3,6);
% imagesc(reshape(nodeBel(1,:),size(img)));
% title('EBP');
% axis image;
% colormap gray;
%% Gibbs Sampling
% z = mrfGs(A, nodePot, edgePot, epoch);
% 
% subplot(2,3,6);
% imagesc(reshape(z(1,:),size(img)));
% title('GS');
% axis image;
% colormap gray;
%% Exact
% z = mrfBf(A, nodePot, edgePot);
% 
% subplot(2,3,6);
% imagesc(reshape(z(1,:),size(img)));
% title('Exact');
% axis image;
% colormap gray;