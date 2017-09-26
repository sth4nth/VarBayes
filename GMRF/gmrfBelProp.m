function mu = gmrfBelProp(Lambda, eta, epoch)
% Belief propagation for latent Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 3
    epoch = 10;
end

J = Lambda;
h = Lambda;
for iter = 1:epoch
    for i = 1:n
        in = nonzeros(Lambda(:,i));                      % incoming message index
        for l = in'

        end
    end
end


function i = rd(i, m)
% reverse direction edge index
i = mod(i+m-1,2*m)+1;

function i = ud(i, m)
% undirected edge index
i = mod(i-1,m)+1;