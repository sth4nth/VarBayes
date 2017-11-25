%% Original image
clear; close all;
data = load('letterX.mat');
img = double(data.X); 
img = sign(img-mean(img(:)));

figure
subplot(2,2,1);
imagesc(img);
title('Original image');
axis image;
colormap gray;
%% Parameters
J = 1;
sigma = 1;
epoch = 10;
%% Noisy image
x = img + sigma*randn(size(img)); % noisy signal
subplot(2,2,2);
imagesc(x);
title('Noisy image');
axis image;
colormap gray;
%% Construct graph
[B,np,fp] = im2fg(x,sigma,J);
[A, nodePot, edgePot] = im2mrf(x, sigma, J);
%% Mean field on a factor graph
nb = fgMf(B, np, fp, epoch);
nodeBel = reshape(cell2mat(nb),2,[]);
nodeBel0 = meanField(A, nodePot, edgePot, epoch);
maxdiff(nodeBel, nodeBel0)

subplot(2,2,3);
imagesc(reshape(nodeBel(1,:),size(img)));
title('Mean Field');
axis image;
colormap gray;
%% Belief propagation on a factor graph
% [nodeBel1,edgeBel1] = belProp(A, nodePot, edgePot, epoch);
[nb1, fb1] = fgBp(B, np, fp, epoch);


subplot(2,2,4);
imagesc(reshape(nodeBel1(1,:),size(img)));
title('Belief Propagation');
axis image;
colormap gray;

