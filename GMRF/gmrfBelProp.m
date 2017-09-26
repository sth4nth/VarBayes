function mu = gmrfBelProp(Lambda, eta, epoch)
% Mean field for latent Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 3
    epoch = 10;
end

J = Lambda;
h = Lambda;
                   % message
for iter = 1:epoch
    for i = 1:n
        in = nonzeros(A(:,i));                      % incoming message index
        nb = nodePot(:,i).*prod(mu(:,in),2);                       % product of incoming message
        for l = in'
            ep = edgePot(:,:,ud(l,m));
            mu(:,rd(l,m)) = normalize(ep*(nb./mu(:,l)));
        end
    end
end

nodeBel = zeros(k,n);
for i = 1:n
    nodeBel(:,i) = nodePot(:,i).*prod(mu(:,nonzeros(A(:,i))),2);
end
nodeBel = normalize(nodeBel,1);

edgeBel = zeros(k,k,m);
for l = 1:m
    eij = e(l);
    eji = eij+m;
    ep = edgePot(:,:,eij);
    nbt = nodeBel(:,t(l))./mu(:,eij);
    nbs = nodeBel(:,s(l))./mu(:,eji);
    eb = (nbt*nbs').*ep;
    edgeBel(:,:,eij) = eb./sum(eb(:));
end

function i = rd(i, m)
% reverse direction edge index
i = mod(i+m-1,2*m)+1;

function i = ud(i, m)
% undirected edge index
i = mod(i-1,m)+1;