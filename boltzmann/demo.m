%% Original image
clear; close all;
data = load('letterX.mat');
img = double(data.X); 
img = sign(img-mean(img(:)));

figure
subplot(2,3,1);
imagesc(img);
colormap gray
title('Original image');
axis image;
colormap gray;
%% Parameters
J = 1;
sigma = 1;
epoch = 10;
%% Noisy image
x = img + sigma*randn(size(img)); % noisy signal
subplot(2,3,2);
imagesc(x);
title('Noisy image');
axis image;
colormap gray;
%% Parameter
z = [1;-1];
y = reshape(x,1,[]);
nodePot = (y-z).^2/(2*sigma^2);
edgePot = -J*(z*z');

[s,t] = find(lattice(size(x)));
A = sparse(s,t,-J);
b = -0.5*diff(nodePot);
%% Mean field for Boltzmann machine
mu = bmMf(A, b, z, epoch);

subplot(2,3,4);
imagesc(reshape(mu,size(img)));
title('Boltzmann MF');
axis image;
colormap gray;
%% Mean field for Ising MRF
mu0 = isMf(A, b, epoch);
maxdiff(mu0,mu)
subplot(2,3,5);

imagesc(reshape(mu0,size(img)));
title('Ising MF');
axis image;
colormap gray;
%% Mean field for discrete MRF
A = double(logical(A));
nodeBel = meanField(A, nodePot, edgePot, epoch);

% nodeBel = imageMeanField(M, N, nodePot, repmat(edgePot,1,1,n), epoch);
maxdiff(mu,z'*nodeBel)
maxdiff(nodeBel,0.5*(1+z*mu))
theta = atanh(mu);
maxdiff(nodeBel,normalize(exp(z*theta)))

subplot(2,3,3);
imagesc(reshape(nodeBel(1,:),size(img)))
title('General MF');
axis image;
colormap gray;