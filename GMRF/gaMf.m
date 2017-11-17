function [mu, lb] = gaMf(eta, Lambda, epoch)
% Mean field for Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 4
    epoch = 10;
end
dg = diag(Lambda);  
mu = eta;
lb = -inf(1,epoch+1);
for iter = 1:epoch
    for i = 1:numel(mu)
        [~,j,w] = find(Lambda(i,:));             
        mu(i) = (eta(i)-dot(w,mu(j)))/dg(i)+mu(i);       % j contain i
    end
    lb(iter+1) = gaGibbs(eta, Lambda, mu);
end
lb = lb(2:end);