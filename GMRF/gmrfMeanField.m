function mu = gmrfMeanField(x, lambda, L, epoch)
% Mean field for latent Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 4
    epoch = 10;
end

% lnZ = log(2*pi./Lii)/2;
% H = log(2*pi./Lii)/2+1/2;
% cont = sum(lnZ+H)/2;
% cc = sum(log(2*pi./Lii)+1/2)/2;
% LB = -inf(1,epoch+1);

n = numel(x);
eta = lambda.*x;
Lambda = lambda+reshape(diag(L),size(x));  % diagonal of Lambda
dg = sub2ind([n,n],1:n,1:n);
L(dg) = 0;              % remove diagonal elements
mu = x;
for iter = 1:epoch
    for i = 1:numel(mu)
        [~,j,w] = find(L(i,:));             % neighbors
        mu(i) = (eta(i)-sum(w.*mu(j)))/Lambda(i);
    end
%     E = Lii.*mu.^2-eta.*mu+1/2;
%     T = lnZ+H-E;
%     LB(iter+1) = sum(T(:))/2; 
end
