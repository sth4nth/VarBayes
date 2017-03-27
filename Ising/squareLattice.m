function A = squareLattice( sz )
% Create grid undirected graph from size parameter
% Input:
%   sz: size
% Output:
%   G: graph object
% Written by Mo Chen (sth4nth@gmail.com)
nRows = sz(1);
nCols = sz(2);

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