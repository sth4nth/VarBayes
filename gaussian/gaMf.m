function [mu, lnZ] = gaMf(eta, Lambda, epoch)
% Mean field for Gaussian MRF
%   eta, Lambda: Gausiian MRF parameters
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 3
    epoch = 10;
end
dg = diag(Lambda);  
mu = eta;
lnZ = -inf(1,epoch+1);
for iter = 1:epoch
    for i = 1:numel(mu)
        [~,j,w] = find(Lambda(i,:));             
        mu(i) = (eta(i)-dot(w,mu(j)))/dg(i)+mu(i);       % j contains i
    end
    lnZ(iter+1) = gaGibbsEnergy(eta, Lambda, mu);
end
lnZ = lnZ(2:end);