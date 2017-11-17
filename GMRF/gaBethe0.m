function [lnZ, E, H] = gaBethe0(eta, Lambda, h, J)
% Bethe energy of Gaussian MRF, valid for itermedia solution during iterations
% Written by Mo Chen (sth4nth@gmail.com)
hn = full(sum(h,1));
Jn = full(sum(J,1));
mu = hn./Jn;
sigma = 1./Jn;
h_ = (hn-h)';  % h_(i,j)=hi\j
J_ = (Jn-J)';  % J_(i,j)=Ji\j
Sigma = Lambda./(Lambda.*Lambda'-J_.*J_');
n = numel(mu);
dg = sub2ind([n,n],1:n,1:n);
Sigma(dg) = sigma;

E = -0.5*dot(Lambda(dg),mu.^2+sigma)+eta*mu';
for i = 1:n
    for j = (i+1):n
        hij = [h_(i,j);h_(j,i)];
        Jij = [J_(i,j),Lambda(i,j);Lambda(j,i),J_(j,i)];
        muij = Jij\hij;
        E = E-Lambda(i,j)*(prod(muij)+Sigma(i,j));
    end
end
lnZ = E+gaBetheEntropy(Sigma);
