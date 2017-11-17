function [h, J] = gaBp(eta, Lambda, epoch)
% Belief propagation for Gaussian MRF
% Written by Mo Chen (sth4nth@gmail.com)
if nargin < 3
    epoch = 10;
end
n = numel(eta);
h = sparse(1:n,1:n,eta,n,n,numel(Lambda));
J = sparse(1:n,1:n,diag(Lambda),n,n,numel(Lambda));               

dg = sub2ind([n,n],1:n,1:n);
NE = logical(Lambda);
NE(dg) = 0;                                                % neighbor index matrix
for iter = 1:epoch
    for i = 1:n
        ne = NE(:,i);                                      % incoming message index
        h_ = sum(h(:,i))-h(ne,i);                         % hi\j
        J_ = sum(J(:,i))-J(ne,i);                         % Ji\j 
        v =  -Lambda(ne,i)./J_;
        h(i,ne) = v.*h_;
        J(i,ne) = v.*Lambda(ne,i);
    end
end
