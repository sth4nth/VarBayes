function T = marginalize(T, vs)
% Marginalize tensor T by vectors vs.
%   T: super symetric tensor
%   vs: d x n vectors
% Written by Mo Chen
assert(size(vs,2) <= ndims(T))
assert(all(size(vs,1) == size(T)));
for d = 1:size(vs,2)
    T = tvp(T,vs(:,d),d);
end
    