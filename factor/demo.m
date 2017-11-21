%% Original image
clear; close all;
data = load('letterX.mat');
img = double(data.X); 
img = sign(img-mean(img(:)));

figure
subplot(2,2,1);
imagesc(img);
colormap gray
title('Original image');
axis image;
colormap gray;
%% Parameters
J = 1;
sigma = 1;
epoch = 50;
%% Noisy image
x = img + sigma*randn(size(img)); % noisy signal
subplot(2,2,2);
imagesc(x);
colormap gray
title('Noisy image');
axis image;
colormap gray;
%% Mean field on a factor graph
[B,np,ep] = im2fg(x);
[nb,L] = fgMf(B, np, ep, epoch);
nodeBel = reshape(cell2mat(nb),2,[]);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),size(img)));
colormap gray
title('Mean Field');
axis image;
colormap gray;
%% Belief propagation on a factor graph

