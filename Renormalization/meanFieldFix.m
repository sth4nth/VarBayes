function mu = meanFieldFix(A, b, x, epoch)
% Parametric (fixed form) mean field for MRF. 
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
theta = -b;
% q = normalize(exp(x*theta),1);
q = softmax(x*theta,1);
mu = x'*q;
for t = 1:epoch
    for i = 1:numel(b)
        [~,j,a] = find(A(i,:));
        theta = -dot(a,mu(j))-b(i);
%         q = normalize(exp(x*theta));
        q = softmax(x*theta);
        mu(i) = x'*q;
    end
end