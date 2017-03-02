%% Make noisy X
clear; close all;
load X.mat

figure
subplot(2,2,1);
imagesc(X);
colormap gray
title('Original X');

[nRows,nCols] = size(X);
X = X + randn(size(X))/2;
subplot(2,2,2);
imagesc(X);
colormap gray
title('Noisy X');


%% MF
[B,np,ep] = im2mrf(X);
[nodeBel,L] = mrfMfAsync(B,np,ep);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field');
%% Belief Propagation
[nodeBel,edgeBel] = mrfLbpAsync(B,exp(np),exp(ep));
subplot(2,2,4);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
title('Belief Propagation');


%% Parallel MF
% [nodeBel0,L0] = mrfMfSync(B,np,ep);
% subplot(2,2,4);
% imagesc(reshape(nodeBel0(2,:),nRows,nCols));
% colormap gray
% title('Mean Field Sync');
% %% Lower bound
% figure
% subplot(2,2,1);
% plot(L)
% title('Mean Field Lower Bound');
% subplot(2,2,2);
% plot(L0)
% title('Mean Field Sync Lower Bound');
% 
% dl = diff(L);
% idx=dl<0;
% dl(~idx)=0;
% plot(dl);
% figure
% plot(L)
% 
