% Done!
clear; close all;
% load letterA.mat;
% X = A;
load letterX.mat
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
[A,nodePot,edgePot] = mrfIsGa(x,sigma,J);
%% Mean Field
[nodeBel,edgeBel,lnZ0] = mrfMf(A,nodePot,edgePot,epoch);

L0 = mrfGibbs(A,nodePot,edgePot,nodeBel);
L1 = mrfBethe(A,nodePot,edgePot,nodeBel,edgeBel);
maxdiff(L0,lnZ0(end))
maxdiff(L0,L1)

subplot(2,3,4);
imagesc(reshape(nodeBel(1,:),size(img)));
title('Mean Field');
axis image;
colormap gray;
%% Undirected Graph Belief Propagation
[nodeBel,edgeBel,lnZ1] = mrfBp(A,nodePot,edgePot,epoch);

subplot(2,3,5);
imagesc(reshape(nodeBel(1,:),size(img)));
title('Belief Propagation');
axis image;
colormap gray;
%% Gibbs Sampling
z = mrfGs(A,nodePot,edgePot,);
[nodeBel,edgeBel,lnZ] = mrfAprox(z,A,nodePot,edgePot);

subplot(2,3,6);
imagesc(reshape(nodeBel(1,:),size(img)));
title('Gibbs Sampling');
axis image;
colormap gray;
%% Energy comparation
figure
epochs = 1:epoch;
plot( epochs,lnZ0,'-', ...
      epochs,lnZ1,'-',...
      epochs,lnZ*ones(1,epoch),'-');
xlabel('epoch');       %  add axis labels and plot title
ylabel('energy');
title('Energy');
legend('MF','BP','GS');