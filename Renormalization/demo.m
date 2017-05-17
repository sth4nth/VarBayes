clear; close all;
% load letterA.mat;
% X = A;
load letterX.mat
%% Original image
epoch = 50;
J = 1;   % ising parameter
sigma = 1; % noise level
[M, N] = size(X); 
img = double(X);
img = sign(img-mean(img(:)));

figure;
subplot(2,3,1);
imagesc(img);
title('image');
axis image;
colormap gray;
%% Noisy image
y = img + sigma*randn(M,N); %y = noisy signal
subplot(2,3,2);
imagesc(y);
title('noisy image');
axis image;
colormap gray;
%% Parameter
z = [1;-1];
y = reshape(y,1,[]);
nodePot = (y-z).^2/(2*sigma^2);
edgePot = -J*(z*z');

[s,t] = find(lattice(size(X)));
A = sparse(s,t,-J);
b = -0.5*diff(nodePot);
%% mean field
mu = meanFieldAb(A, b, epoch);
% maxdiff(mu0,mu)
subplot(2,3,3);
imagesc(reshape(mu,M,N))
title('parametric mean field');
axis image;
colormap gray;
%% Image mean field
nodeBel = imageMeanField(M, N, nodePot, edgePot, epoch);
maxdiff(mu,z'*nodeBel)

subplot(2,3,4);
imagesc(reshape(nodeBel(1,:),M,N))
title('Image mean field');
axis image;
colormap gray;
%% Ising mean field 
h = reshape(0.5*diff(nodePot),M,N);
mu0 = isingMeanField(J, h, epoch);
maxdiff(mu,reshape(mu0,1,[]))
subplot(2,3,5);
imagesc(mu0)
title('Ising mean field');
axis image;
colormap gray;

