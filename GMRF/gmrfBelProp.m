function [mu, J, h] = gmrfBelProp(Lambda, eta, epoch)
% Belief propagation for latent Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 3
    epoch = 10;
end
n = numel(eta);
J = sparse(1:n,1:n,diag(Lambda));                            
h = sparse(1:n,1:n,eta);
for iter = 1:epoch
    for i = 1:n
        ne = find(Lambda(i,:));                      % incoming message index
        Jn = sum(J(ne,i));
        hn = sum(h(ne,i));
        for j = setdiff(ne,i)
            Jk = Jn-J(j,i);
            hk = hn-h(j,i);
            J(i,j) = -Lambda(j,i)*Lambda(i,j)/Jk;
            h(i,j) = -Lambda(j,i)*hk/Jk;
        end
    end
end
mu = full(sum(h,1))./full(sum(J,1));