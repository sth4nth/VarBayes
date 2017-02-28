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
%% Mean field on a factor graph
[B,np,ep] = im2fg(X);
[nb,L] = meanFieldAsync(B,np,ep);
nodeBel = reshape(cell2mat(nb),2,[]);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field');
%% Mean field on a factor graph with async update
[nb0,L0] = meanFieldSync(B,np,ep);
nodeBel0 = reshape(cell2mat(nb0),2,[]);
subplot(2,2,4);
imagesc(reshape(nodeBel0(2,:),nRows,nCols));
colormap gray
title('Mean Field Sync');
%% Lower bound
figure
subplot(2,2,1);
plot(L)
title('Mean Field Lower Bound');
subplot(2,2,2);
plot(L0)
title('Mean Field Sync Lower Bound');