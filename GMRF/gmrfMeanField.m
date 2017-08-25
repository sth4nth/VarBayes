function mu = gmrfMeanField(x, lambda, Lij, Lii, epoch)
% Mean field for latent Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 5
    epoch = 10;
end
mu = x;
for iter = 1:epoch
    for i = 1:numel(mu)
        [~,j,e] = find(Lij(i,:));             % neighbors
        mu(i) = (lambda*x(i)-sum(e.*mu(j)))/(lambda+Lii(i));
    end
end
