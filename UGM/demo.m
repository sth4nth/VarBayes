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
[nbmf, ebmf, L] = meanField(A, np, ep);
subplot(3,3,3);
imagesc(reshape(nbmf(2,:),nRows,nCols));
colormap gray
title('MF');
%% Belief Propagation
[nbbp,ebbp] = belProp(A, np, ep);
subplot(3,3,4);
imagesc(reshape(nbbp(2,:),nRows,nCols));
colormap gray
title('BP');
%% Expectation Propagation
[nbep,ebep] = expProp(A, np, ep);
[nbep0,ebep0] = expProp0(A, np, ep);
maxdiff(nbep0,nbep)
maxdiff(ebep0,ebep)
subplot(3,3,5);
imagesc(reshape(nbep(2,:),nRows,nCols));
colormap gray
title('EP');
%% EP-BP
[nbebp,ebebp] = expBelProp(A, np, ep);
subplot(3,3,6);
imagesc(reshape(nbebp(2,:),nRows,nCols));
colormap gray
title('EBP');