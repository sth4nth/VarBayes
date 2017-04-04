clear; close all;
% load letterA.mat;
% X = A;
load letterX.mat

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
[A,np,ep] = im2mrf0(X);
[nbmf, ebmf, lnZ,lnZ0] = meanField0(A, np, ep);
subplot(3,3,3);
imagesc(reshape(nbmf(2,:),nRows,nCols));
colormap gray
title('MF');
%%
figure
plot(lnZ)
figure
plot(lnZ0)
% lnZ0 = gibbsEnergy0(np, ep, nbmf, ebmf);
% lnZ(end)
% lnZ0
% %% Belief Propagation
% [nbbp,ebbp] = belProp(A, np, ep);
% subplot(3,3,4);
% imagesc(reshape(nbbp(2,:),nRows,nCols));
% colormap gray
% title('BP');
% %% Expectation Propagation
% [nbep,ebep] = expProp(A, np, ep);
% subplot(3,3,5);
% imagesc(reshape(nbep(2,:),nRows,nCols));
% colormap gray
% title('EP');
% %% EP-BP
% [nbebp,ebebp] = expBelProp(A, np, ep);
% subplot(3,3,6);
% imagesc(reshape(nbebp(2,:),nRows,nCols));
% colormap gray
% title('EBP');