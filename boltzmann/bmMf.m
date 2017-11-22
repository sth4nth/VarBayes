function mu = bmMf(A, b, z, epoch)
% Mean field for Boltzmann machine. 
% Input: 
%   z: k x 1 possible value
%   A: n x n edge weight of an undirected graph
%   b: 1 x n node weight of an undirected graph
% Output:
%   mu: k x n expectation value
% Written by Mo Chen (sth4nth@gmail.com)
theta = -b;
q = softmax(z*theta,1);
mu = z'*q;
for t = 1:epoch
    for i = 1:numel(b)
        [~,j,a] = find(A(i,:));
        theta = -dot(a,mu(j))-b(i);
        q = softmax(z*theta);
        mu(i) = z'*q;
    end
end