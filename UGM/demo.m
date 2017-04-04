clear; close all;
% load letterA.mat;
% X = A;
load letterX.mat
%% Original image
epoch = 50;
J = 1;   % ising parameter
sigma  = 1; % noise level

img    = double(X);
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
%% Mean Field
[A, nodePot, edgePot] = im2mrf(y, sigma, J);
[nodeBel, edgeBel, lnZ] = meanField(A, nodePot, edgePot);
lnZ0 = gibbsEnergy(nodePot, edgePot, nodeBel, edgeBel);
lnZ1 = betheEnergy(A, nodePot, edgePot, nodeBel, edgeBel);
maxdiff(lnZ0, lnZ(end))
maxdiff(lnZ0, lnZ1)

subplot(2,3,3);
imagesc(reshape(nodeBel(1,:),size(img)));
title('MF');
axis image;
colormap gray;
%% Belief Propagation
[nodeBel,edgeBel] = belProp(A, nodePot, edgePot);
subplot(2,3,4);
imagesc(reshape(nodeBel(1,:),size(img)));
title('BP');
axis image;
colormap gray;
%% Expectation Propagation
[nodeBel,edgeBel] = expProp(A, nodePot, edgePot);
subplot(2,3,5);
imagesc(reshape(nodeBel(1,:),size(img)));
title('EP');
axis image;
colormap gray;
%% EP-BP
[nodeBel,edgeBel] = expBelProp(A, nodePot, edgePot);
subplot(2,3,6);
imagesc(reshape(nodeBel(1,:),size(img)));
title('EBP');
axis image;
colormap gray;
