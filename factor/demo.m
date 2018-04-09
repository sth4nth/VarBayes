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
epoch = 20;
%% Noisy image
x = img + sigma*randn(size(img)); % noisy signal
subplot(2,2,2);
imagesc(x);
title('Noisy image');
axis image;
colormap gray;
%% Construct graph
[B,nodePot,factorPot] = fgIsGa(x,sigma,J);
%% Mean field on a factor graph
nodeBel0 = fgMf(B, nodePot, factorPot, epoch);

subplot(2,2,3);
imagesc(reshape(nodeBel0(1,:),size(img)));
title('Mean Field');
axis image;
colormap gray;
%% Belief propagation on a factor graph
[nodeBel1,factorBel1] = fgBp(B, nodePot, factorPot, epoch);

subplot(2,2,4);
imagesc(reshape(nodeBel1(1,:),size(img)));
title('Belief Propagation');
axis image;
colormap gray;

