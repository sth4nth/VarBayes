function [Y, c] = nml(X, dim)
% Normalize the vectors to be summing to one
%   By default dim = 1 (columns).
% Written by Michael Chen (sth4nth@gmail.com).
if nargin == 1, 
    % Determine which dimension sum will use
    dim = find(size(X)~=1,1);
    if isempty(dim), dim = 1; end
end
c = sum(X,dim);
Y = bsxfun(@times,X,1./c);