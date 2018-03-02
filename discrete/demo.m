% Done!
clear; close all;
% load letterA.mat;
% X = A;
load letterX.mat
%% Original image
epoch = 100;
J = 1;   % ising parameter
sigma = 1; % noise level

im = double(X);
im = sign(im-mean(im(:)));

figure;
subplot(2,3,1);
imagesc(im);
title('Original image');
axis image;
colormap gray;
%% Noisy image
x = im + sigma*randn(size(im)); % noisy signal
subplot(2,3,2);
imagesc(x);
title('Noisy image');
axis image;
colormap gray;
[A, nodePot, edgePot] = im2mrf(x, sigma, J);
%% Mean Field
[nodeBel, edgeBel, L] = meanField(A, nodePot, edgePot, epoch);

L0 = gibbs(nodePot, edgePot, nodeBel, edgeBel);
L1 = bethe(A, nodePot, edgePot, nodeBel, edgeBel);
maxdiff(L0, L(end))
maxdiff(L0, L1)

subplot(2,3,3);
imagesc(reshape(nodeBel(1,:),size(im)));
title('MF');
axis image;
colormap gray;
%% Belief Propagation
[nodeBel,edgeBel] = belProp(A, nodePot, edgePot, epoch);

[nodeBel0,edgeBel0] = belProp0(A, nodePot, edgePot, epoch);
maxdiff(nodeBel,nodeBel0)
maxdiff(edgeBel,edgeBel0)

subplot(2,3,4);
imagesc(reshape(nodeBel(1,:),size(im)));
title('BP');
axis image;
colormap gray;
%% Expectation Propagation
[nodeBel,edgeBel] = expProp(A, nodePot, edgePot, epoch);

lnZ0 = bethe(A, nodePot, edgePot, nodeBel, edgeBel);

[nodeBel0,edgeBel0] = expProp0(A, nodePot, edgePot, epoch);
maxdiff(nodeBel,nodeBel0)
maxdiff(edgeBel,edgeBel0)

subplot(2,3,5);
imagesc(reshape(nodeBel(1,:),size(im)));
title('EP');
axis image;
colormap gray;
%% EP-BP
% [nodeBel,edgeBel] = expBelProp(A, nodePot, edgePot, epoch);
% 
% [nodeBel0,edgeBel0] = expBelProp0(A, nodePot, edgePot, epoch);
% maxdiff(nodeBel,nodeBel0)
% maxdiff(edgeBel,edgeBel0)
% 
% subplot(2,3,6);
% imagesc(reshape(nodeBel(1,:),size(im)));
% title('EBP');
% axis image;
% colormap gray;
%% GS
z = mrfGs(A, nodePot, edgePot, epoch);

subplot(2,3,6);
imagesc(reshape(z(1,:),size(im)));
title('GS');
axis image;
colormap gray;

