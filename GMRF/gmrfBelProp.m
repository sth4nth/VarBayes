function mu = gmrfBelProp(Lambda, eta, epoch)
% Belief propagation for latent Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 3
    epoch = 10;
end

J
h
for iter = 1:epoch
    for i = 1:numel(mu)
        [~,j,e] = find(Lij(i,:));             % neighbors
%         mu(i) = (lambda*x(i)-sum(e.*mu(j)))/(lambda+Lii(i));
    end
end
