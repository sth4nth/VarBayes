function mu = isingMeanField(A, b, epoch)
% Mean field for Ising MRF. 
% Input: 
%   A: n x n edge weight of an undirected graph
%   b: 1 x n node weight of an undirected graph
% Output:
%   mu: k x n expectation value
% Written by Mo Chen (sth4nth@gmail.com)
mu = tanh(-b);
for t = 1:epoch
    for i = 1:numel(b)
        [~,j,a] = find(A(i,:));
        mu(i) = tanh(-dot(a,mu(j))-b(i));
    end
end