function M = tvp( T, v, d )
% Tensor vector (inner) product (contraction) along a dimension
% Written by Mo Chen
assert(max(size(v)==numel(v)));
sz = ones(1,ndims(T));
sz(d) = numel(v);
M = sum(T.*reshape(v,sz),d);

