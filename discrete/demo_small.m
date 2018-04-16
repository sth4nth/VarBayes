clear; close all;
l = 3;
X = ones(l,l);
h = ceil(l/2);
for i = 1:l
    X(i,h) = 0;
    X(h,i) = 0;
end
img = double(X);
img = sign(img-mean(img(:)));

figure;
subplot(2,3,1);
imagesc(img);
title('Original image');
axis image;
colormap gray;
%% Noisy image
sigma = 0.5; % noise level
x = img + sigma*randn(size(img)); % noisy signal
subplot(2,3,2);
imagesc(x);
title('Noisy image');
axis image;
colormap gray;
%% Construct MRF data
epoch = 20;
J = 1;   % ising parameter
[A,nodePot,edgePot] = mrfIsGa(x,sigma,J);
%% Exact
[nodeBel,edgeBel,lnZ] = mrfExact(A,nodePot,edgePot);
subplot(2,3,3);
imagesc(reshape(nodeBel(1,:),size(img)));
title('Exact');
axis image;
colormap gray;
%% Mean Field
[nodeBel0,edgeBel0,lnZ0] = mrfMf(A,nodePot,edgePot,epoch);

L0 = mrfGibbs(A,nodePot,edgePot,nodeBel);
L1 = mrfBethe(A,nodePot,edgePot,nodeBel,edgeBel);
maxdiff(L0,lnZ0(end))
maxdiff(L0,L1)

subplot(2,3,4);
imagesc(reshape(nodeBel0(1,:),size(img)));
title('Mean Field');
axis image;
colormap gray;
%% Undirected Graph Belief Propagation
[nodeBel1,edgeBel1,lnZ1] = mrfBp(A,nodePot,edgePot,epoch);

subplot(2,3,5);
imagesc(reshape(nodeBel1(1,:),size(img)));
title('Belief Propagation');
axis image;
colormap gray;
% %% Gibbs Sampling
% burnin = 100;
% t = 20;
% z = mrfGs(A,nodePot,edgePot,burnin,t);
% [nodeBel,edgeBel,lnZ] = mrfAprox(z,A,nodePot,edgePot);
% 
% subplot(2,3,6);
% imagesc(reshape(nodeBel(1,:),size(img)));
% title('Gibbs Sampling');
% axis image;
% colormap gray;
%% Energy comparation
figure
lnZ = lnZ*ones(1,epoch);
epochs = 1:epoch;
plot( epochs,lnZ,'b-', ...
      epochs,lnZ0,'r-', ...
      epochs,lnZ1,'k-');
xlabel('epoch');       %  add axis labels and plot title
ylabel('energy');
title('Energy Comparation');
legend('Exact','MF','BP');