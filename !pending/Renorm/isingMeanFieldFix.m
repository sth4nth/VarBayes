function mu = isingMeanFieldFix(A, b, epoch)
% Parametric (fixed form) mean field for ising. 
% This function optimizes wrt parameter of distribution instead of probability.
% Input: 
%   x: k x 1 possible value
%   A: n x n edge weight of an undirected graph
%   b: 1 x n node weight of an undirected graph
% Output:
%   p: k x n probability
%   h: 1 x n parameter vector
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 3
    epoch = 10;
end
mu = tanh(-b);
for t = 1:epoch
    for i = 1:numel(b)
        [~,j,a] = find(A(i,:));
        mu(i) = tanh(-dot(a,mu(j))-b(i));
    end
end