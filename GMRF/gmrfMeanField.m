function [mu, L] = gmrfMeanField(x, lambda, Lij, Lii, epoch)
% Mean field for latent Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 5
    epoch = 10;
end

lnZ = log(2*pi./Lii)/2;
H = log(2*pi./Lii)/2+1/2;
cont = sum(lnZ+H)/2;
cc = sum(log(2*pi./Lii)+1/2)/2;



eta = lambda.*x;
Lambda = lambda+Lii;
L = -inf(1,epoch+1);
mu = x;
for iter = 1:epoch
    for i = 1:numel(mu)
        [~,j,e] = find(Lij(i,:));             % neighbors
        mu(i) = (eta(i)-sum(e.*mu(j)))/(lambda+Lii(i));
    end
    E = Lii.*mu.^2-eta.*mu+1/2;
    T = lnZ+H-E;
    L(iter+1) = sum(T(:))/2; 
end
