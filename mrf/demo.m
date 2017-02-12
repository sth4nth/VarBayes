%% Make noisy X
clear; close all;
load X.mat
subplot(2,2,1);
imagesc(X);
colormap gray
title('Original X');

X = X + randn(size(X))/2;
subplot(2,2,2);
imagesc(X);
colormap gray
title('Noisy X');


[nRows,nCols] = size(X);
nNodes = nRows*nCols;
nStates = 2;

adj = sparse(nNodes,nNodes);

% Add Down Edges
ind = 1:nNodes;
exclude = sub2ind([nRows nCols],repmat(nRows,[1 nCols]),1:nCols); % No Down edge for last row
ind = setdiff(ind,exclude);
adj(sub2ind([nNodes nNodes],ind,ind+1)) = 1;

% Add Right Edges
ind = 1:nNodes;
exclude = sub2ind([nRows nCols],1:nRows,repmat(nCols,[1 nRows])); % No right edge for last column
ind = setdiff(ind,exclude);
adj(sub2ind([nNodes nNodes],ind,ind+nRows)) = 1;

% Add Up/Left Edges
adj = adj+adj';
B = ug2fg(adj);

nEdges = size(B,1);
nodePot = zeros(nStates,nNodes);
edgePot = zeros(nStates,nStates,nEdges);
    
Xstd = UGM_standardizeCols(reshape(X,[1 1 nNodes]),1);
nodePot(1,:) = exp(-1-2.5*Xstd(:));
nodePot(2,:) = 1;
for e = 1:nEdges
    idx = find(B(e,:));
    ps = exp(1.8 + .3*1/(1+abs(Xstd(idx(1))-Xstd(idx(2)))));
    edgePot(:,:,e) = [ps 1;1 ps];
end

[nodeBel, L] = mrf_mf(B, nodePot, edgePot);
subplot(2,2,3);
imagesc(reshape(nodeBel(2,:),nRows,nCols));
colormap gray
title('Mean Field Estimates of Marginals');