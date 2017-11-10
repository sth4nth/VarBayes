function lnZ = betheGmrf(Lambda, eta, J, h)
% Compute Bethe free energy of Gaussian MRF
sigma2 = 1./full(sum(J,1));
mu = full(sum(h,1))./sigma2;
JJ = sum(J,1)-J;  % Ji\j
hh = sum(h,1)-h;  % hi\j

Lii = diag(Lambda);
Ei = -0.5*dot(Lii(:),mu(:).^2+sigma2(:))+dot(eta(:),mu(:));
Hi = 0.5*sum(log(2*pi*exp(1)*sigma2));
n = numel(eta);
Eij = sparse(n,n);
Hij = sparse(n,n);
for i = 1:n
    for j = (i+1):n
        h2 = [hh(i,j);hh(j,i)];
        J2 = [JJ(i,j),Lambda(i,j);Lambda(j,i),JJ(j,i)];
        Sigma2 = inv(J2);
        m2 = Sigma2\h2;
        Eij(i,j) = -Lambda(i,j)*(prod(m2)+Sigma2(1,2));
        Hij(i,j) = 0.5*log((2*pi*exp(1))^2*det(Sigma2)); 
    end
end
d = full(sum(logical(Lambda),1));  % remove diagonal
lnZ = Ei+sum(Eij(:))+sum((d-1).*Hi)-sum(Hij(:));