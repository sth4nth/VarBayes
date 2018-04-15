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
epoch = 50;
%% Noisy image
x = img + sigma*randn(size(img)); % noisy signal
subplot(2,2,2);
imagesc(x);
title('Noisy image');
axis image;
colormap gray;
%% Construct graph
[B,nodePot,factorPot] = fgIsGa(x,sigma,J);  % factor graph
[A,np,edgePot] = mrfIsGa(x,sigma,J);    % undirected graph
%% Mean field on a factor graph
nodeBel0 = fgMf(B,nodePot,factorPot,epoch);

subplot(2,2,3);
imagesc(reshape(nodeBel0(1,:),size(img)));
title('Mean Field');
axis image;
colormap gray;
%% Belief propagation on a factor graph
[nodeBel,factorBel] = fgBp(B,nodePot,factorPot,epoch);

[nb,eb] = mrfBp(A,nodePot,edgePot,epoch);
maxdiff(nodeBel,nb)
fb = reshape(cell2mat(factorBel),2,2,[]);
maxdiff(fb,eb)

lnZ = fgBethe(B,nodePot,factorPot,nodeBel,factorBel);
lnZ0 = mrfBethe(A,nodePot,edgePot,nb,eb);
maxdiff(lnZ,lnZ0)

subplot(2,2,4);
imagesc(reshape(nodeBel(1,:),size(img)));
title('Belief Propagation');
axis image;
colormap gray;

