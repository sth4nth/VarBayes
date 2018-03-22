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
epoch = 5;
n = numel(img);
a = 1;                       % edge weight
A = a*lattice(size(img));    % adjacent matrix
d = full(sum(A,1));          % node degree
D = sparse(1:n,1:n,d,n,n,n); % degree matrix
L = D-A;                     % Laplacian matrix: L(i,j) = -a, L(i,i) = d(i)
%% Closed form (exact) solution for Gaussian Posterior
x = reshape(img,1,[]);
Lambda = lambda*speye(n)+L;
eta = lambda*x;
mu0 = eta/Lambda;
% True freee energy
lnZ0 = gaFreeEnergy(eta, Lambda);

subplot(2,3,3);
imagesc(reshape(mu0,size(img)));
title('Gaussian exact');
axis image;
colormap gray;
%% Gaussian MRF Mean Field
[mu1, lnZ1] = gaMf(eta, Lambda, epoch);
maxdiff(mu0(:),mu1(:))

subplot(2,3,4);
imagesc(reshape(mu1,size(img)));
title('GMRF MF');
axis image;
colormap gray;
%% Gaussian MRF Belief Propagation
[mu2, Sigma2, lnZ2] = gaBp(eta, Lambda, epoch);
maxdiff(mu0(:),mu2(:))

subplot(2,3,5);
imagesc(reshape(mu2,size(img)));
title('GMRF BP');
axis image;
colormap gray;
%% Gibbs energy Vs Bethe energy
lnZg = gaGibbsEnergy(eta, Lambda, mu1);
lnZb = gaBetheEnergy(eta, Lambda, mu2, sparse(1:n,1:n,1./diag(Lambda)));
maxdiff(lnZg,lnZb)
%% Energy comparation
figure
epochs = 1:epoch;
plot( epochs,lnZ0*ones(1,epoch),'-', ...
      epochs,lnZ1,'-', ...
      epochs,lnZ2,'-');
xlabel('epoch');       %  add axis labels and plot title
ylabel('energy');
title('Energy');
legend('Exact','MF','BP');