function A = im2ug(X)

[nRows,nCols] = size(X);
nNodes = nRows*nCols;
A = sparse(nNodes,nNodes);

% Add Down Edges
ind = 1:nNodes;
exclude = sub2ind([nRows nCols],repmat(nRows,[1 nCols]),1:nCols); % No Down edge for last row
ind = setdiff(ind,exclude);
A(sub2ind([nNodes nNodes],ind,ind+1)) = true;

% Add Right Edges
ind = 1:nNodes;
exclude = sub2ind([nRows nCols],1:nRows,repmat(nCols,[1 nRows])); % No right edge for last column
ind = setdiff(ind,exclude);
A(sub2ind([nNodes nNodes],ind,ind+nRows)) = true;

% Add Up/Left Edges
A = A+A';

