clear; close all;
%% Original Image
load X.mat
figure
subplot(3,3,1);
imagesc(X);
colormap gray
title('Original X');
%% Noisy Image
[nRows,nCols] = size(X);
X = X + randn(size(X))/2;
subplot(3,3,2);
imagesc(X);
colormap gray
title('Noisy X');
%% Mean Field
[A,np,ep] = im2mrf(X);
% [nbmf, ebmf, L] = meanField(A, np, ep);
% subplot(3,3,4);
% imagesc(reshape(nbmf(2,:),nRows,nCols));
% colormap gray
% title('Mean Field');
%% Belief Propagation
tic
[nbbp,ebbp] = belProp(A, np, ep);
toc
subplot(3,3,5);
imagesc(reshape(nbbp(2,:),nRows,nCols));
colormap gray
title('Belief Propagation');
%%
tic
[nbep,ebep] = belProp0(A, np, ep);
toc
subplot(3,3,6);
imagesc(reshape(nbbp(2,:),nRows,nCols));
colormap gray
title('Expectation Propagation');

% maxdiff(nbbp,nbep)
% maxdiff(ebbp,ebep)
%%
tic
[nbep,ebep] = belProp1(A, np, ep);
toc
subplot(3,3,6);
imagesc(reshape(nbbp(2,:),nRows,nCols));
colormap gray
title('Expectation Propagation');

maxdiff(nbbp,nbep)
maxdiff(ebbp,ebep)