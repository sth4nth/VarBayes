clear; close all;
%% Original Image
load X.mat
figure
subplot(2,2,1);
imagesc(X);
colormap gray
title('Original X');
%% Noisy Image
[nRows,nCols] = size(X);
X = X + randn(size(X))/2;
subplot(2,2,2);
imagesc(X);
colormap gray
title('Noisy X');
%% Mean Field
[A,np,ep] = im2mrf(X);
% [nbmf, ebmf, L] = meanField(A, np, ep);
% subplot(2,2,3);
% imagesc(reshape(nbmf(2,:),nRows,nCols));
% colormap gray
% title('Mean Field');
%% Belief Propagation
[nbbp,ebbp] = belProp(A, exp(np), exp(ep));
subplot(2,2,3);
imagesc(reshape(nbbp(2,:),nRows,nCols));
colormap gray
title('Belief Propagation');
%%
% [nbbp0,ebbp0] = belProp0(A, exp(np), exp(ep));
% subplot(2,2,4);
% imagesc(reshape(nbbp0(2,:),nRows,nCols));
% colormap gray
% title('Belief Propagation0');
% 
% 
% maxdiff(nbbp,nbbp0)
% maxdiff(ebbp,ebbp0)