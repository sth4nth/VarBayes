function mu = boltzMeanField(A, b, x, epoch)
% Mean field for Boltzmann machine. 
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
q = softmax(x*theta,1);
mu = x'*q;
for t = 1:epoch
    for i = 1:numel(b)
        [~,j,a] = find(A(i,:));
        theta = -dot(a,mu(j))-b(i);
        q = softmax(x*theta);
        mu(i) = x'*q;
    end
end