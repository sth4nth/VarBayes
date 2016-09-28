function [ err ] = maxdiff( x, y )
%Maximum absolute difference
    assert(all(size(x)==size(y)));
    err = max(abs(x(:)-y(:)));
end

