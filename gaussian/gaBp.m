function [mu, Sigma, lnZ] = gaBp(eta, Lambda, epoch)
% Belief propagation for Gaussian MRF
%   eta, Lambda: Gausiian MRF parameters
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 3
    epoch = 10;
end
n = numel(eta);
h = sparse(1:n,1:n,eta,n,n,numel(Lambda));
J = sparse(1:n,1:n,diag(Lambda),n,n,numel(Lambda));               

dg = sub2ind([n,n],1:n,1:n);
NE = logical(Lambda);
NE(dg) = false;                                                % neighbor index matrix
lnZ = -inf(1,epoch+1);
for iter = 1:epoch
    for i = 1:n
        ne = NE(:,i);                                      % incoming message index
        h_ = sum(h(:,i))-h(ne,i);                         % hi\j
        J_ = sum(J(:,i))-J(ne,i);                         % Ji\j 
        v =  -Lambda(ne,i)./J_;
        h(i,ne) = v.*h_;
        J(i,ne) = v.*Lambda(ne,i);
    end
    [mu, Sigma] = gaMarginal(h, J, Lambda);
    lnZ(iter+1) = gaBetheEnergy(eta, Lambda, mu, Sigma);
end
lnZ = lnZ(2:end);

function [mu, Sigma] = gaMarginal(h, J, Lambda)
% Compute the marginal distribution from messages of BP/EP
%   h, J: BP solution for Gaussian MRF
%   Lambda: Gaussian MRF precision matrix
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

% function lnZ = gaBetheEnergy(eta, Lambda, h, J)
% % Bethe energy of Gaussian MRF, valid for intermediate solutions during iterations
% % Written by Mo Chen (sth4nth@gmail.com)
% hn = full(sum(h,1));
% Jn = full(sum(J,1));
% mu = hn./Jn;
% sigma = 1./Jn;
% h_ = (hn-h)';  % h_(i,j)=hi\j
% J_ = (Jn-J)';  % J_(i,j)=Ji\j
% Sigma = Lambda./(Lambda.*Lambda'-J_.*J_');
% n = numel(mu);
% dg = sub2ind([n,n],1:n,1:n);
% Sigma(dg) = sigma;
% 
% E = -0.5*dot(Lambda(dg),mu.^2+sigma)+eta*mu';
% for i = 1:n
%     for j = (i+1):n
%         hij = [h_(i,j);h_(j,i)];
%         Jij = [J_(i,j),Lambda(i,j);Lambda(j,i),J_(j,i)];
%         muij = Jij\hij;                                 % Maybe this can be simplified?
%         E = E-Lambda(i,j)*(prod(muij)+Sigma(i,j));
%     end
% end
% lnZ = E+gaBetheEntropy(Sigma);
