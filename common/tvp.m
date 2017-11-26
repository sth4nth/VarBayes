function M = tvp(T, v, d)
% Tensor vector (inner) product (contraction) along dimension d.
% Written by Mo Chen
assert(size(v,2)==1 && size(v,1)==size(T,d));
sz = ones(1,ndims(T));
sz(d) = numel(v);
M = sum(T.*reshape(v,sz),d);

