function idx = fgn(B, i)
% find neighors of i in a bipartite factor graph B
B = logical(B);
idx = any(B(:,B(i,:)),2);
idx(i) = false;
