function mu = gmrfMeanField(L, x, epoch)
% Mean field for latent Gaussian MRF
% Assuming egdePot is symmetric
% Input: 
%   L: n x n precision matrix of prior
%   h: 1 x n lambda*x
% Output:
%   mu: 1 x n mean parameter
%   L: variational lower bound
% Written by Mo Chen (sth4nth@gmail.com)
tol = 0;
if nargin < 4
    epoch = 10;
    tol = 1e-4;
end
l = diag(L);
L = L-spdiags(l);
mu = h;
for iter = 1:epoch
    mu0 = mu;
    for i = 1:numel(L)
        [~,j,e] = find(L(i,:));             % neighbors
        mu(i) = (h(i)+dot(mu(j),e))/l(i);
    end
    if max(abs(mu-mu0(:))) < tol; break; end
end
