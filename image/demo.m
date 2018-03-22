%% Original image
clear; close all;
data = load('letterX.mat');
img = double(data.X); 
img = sign(img-mean(img(:)));

figure
subplot(2,3,1);
imagesc(img);
title('Original image');
axis image;
colormap gray;
%% Noisy image
sigma = 1;
x = img + sigma*randn(size(img)); % noisy signal
subplot(2,3,2);
imagesc(x);
title('Noisy image');
axis image;
colormap gray;
%% Parameter
epoch = 50;
J = 1;
z = [1;-1];
k = numel(z);
y = reshape(x,1,[]);
nodePot = (y-z).^2/(2*sigma^2);
edgePot = -J*(z*z');
h = reshape(0.5*diff(nodePot),size(img));
%% 2d-Ising mean field 
mu = imIsMf(J, h, epoch);

subplot(2,3,3);
imagesc(mu);
title('Ising MF');
axis image;
colormap gray;
%% Image mean field
nodeBel0 = imMf(reshape(nodePot,[k,size(img)]), edgePot, epoch);
nodeBel0 = reshape(nodeBel0,k,[]);
maxdiff(reshape(mu,1,[]),z'*nodeBel0)

subplot(2,3,6);
imagesc(reshape(nodeBel0(1,:),size(img)));
title('Image MF');
axis image;
colormap gray;
%% TBD 
%% General mean field
A = lattice(size(img));
[s,t,e] = find(tril(A));
e(:) = 1:numel(e);
A = sparse([s;t],[t;s],[e;e]);
edgePot = repmat(edgePot,[1, 1, nnz(tril(A))]);
[nodeBel, edgeBel, lnZ] = meanField(A, nodePot, edgePot, epoch);
maxdiff(nodeBel0,nodeBel)
[nodeBel1, edgeBel1] = mrfMf(A, -nodePot, -edgePot, epoch);
maxdiff(nodeBel0,nodeBel1)
% 
% subplot(2,3,6);
% imagesc(reshape(nodeBel(1,:),size(img)));
% title('General MF');
% axis image;
% colormap gray;
%% 2d Ising Gibbs sampling
z1 = imIsGs(J, h, epoch);

subplot(2,3,4);
imagesc((z1+1)/2);
title('Ising GS');
axis image;
colormap gray;
%% 2d Ising Metropolis Hasting
z2 = imIsGs(J, h, epoch);

subplot(2,3,5);
imagesc((z2+1)/2);
title('Ising MH');
axis image;
colormap gray;

