%% Done

%% Original image
clear; close all;
data = load('letterX.mat');
img = double(data.X); 
img = sign(img-mean(img(:)));
figure;
subplot(2,3,1);
imagesc(img);
title('Original image');
axis image;
colormap gray;
%% Noisy image 
lambda = 4; % noise level lambda = 1/sigma^2
img = img + sqrt(1/lambda)*randn(size(img)); 
subplot(2,3,2);
imagesc(img);
title('Noisy image');
axis image;
colormap gray;
%% Parameters
epoch = 50;
n = numel(img);
a = 1;                       % edge weight: L(i,j) = -a
A = a*lattice(size(img));    % adjacent matrix
d = full(sum(A,1));          % node degree: L(i,i) = d(i)
D = sparse(1:n,1:n,d,n,n,n); % degree matrix
L = D-A;                     % Laplacian matrix
%% Closed form Gaussian Posterior
x = reshape(img,1,[]);
Lambda = lambda*speye(n)+L;
eta = lambda*x;
mu0 = eta/Lambda;

subplot(2,3,3);
imagesc(reshape(mu0,size(img)));
title('Closed form');
axis image;
colormap gray;
%% General Gaussian MRF Mean Field
[mu1, lb1] = gaMf(eta, Lambda, epoch);
maxdiff(mu0(:),mu1(:))

subplot(2,3,5);
imagesc(reshape(mu1,size(img)));
title('GMRF MF');
axis image;
colormap gray;
%% Gaussian MRF Belief Propagation
[h, J] = gaBp(eta, Lambda, epoch);
[mu, Sigma] = gaMarginal(h, J, Lambda);
maxdiff(mu0(:),mu(:))

subplot(2,3,6);
imagesc(reshape(mu,size(img)));
title('GMRF BP');
axis image;
colormap gray;
%% Gibbs energy
lnZ = gaGibbs(eta, Lambda, mu);
lnZ0 = gaBethe(eta, Lambda, mu, sparse(1:n,1:n,1./diag(Lambda)));
maxdiff(lnZ,lnZ0)
%% Bethe energy
lnZ = gaBethe(eta, Lambda, mu, Sigma);
[lnZ0] = gaBethe0(eta, Lambda, h, J);
maxdiff(lnZ,lnZ0)
%% True freee energy
lnZ = gaEnergy(eta, Lambda);
