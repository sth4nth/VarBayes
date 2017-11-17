function [mu, Sigma] = gaMarginal(h, J, Lambda)
% Compute the marginal distribution from messages of BP/EP
% Written by Mo Chen (sth4nth@gmail.com)
hn = full(sum(h,1));
Jn = full(sum(J,1));
mu = hn./Jn;
sigma = 1./Jn;
J_ = (Jn-J)';  % J_(i,j)=Ji\j
Sigma = Lambda./(Lambda.*Lambda'-J_.*J_');
n = numel(mu);
dg = sub2ind([n,n],1:n,1:n);
Sigma(dg) = sigma;