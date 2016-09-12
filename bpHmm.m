function [ gamma, llh ] = bpHmm( x, s, A, E )
% Belief propagation alogrithm for HMM to compute posterior p(z_i|x)
% Input:
%   x: 1xn observation
%   s: kx1 starting probability of p(z_1|s)
%   A: kxk transition probability
%   E: kxd emission probability
% Output:
%   m: 1xn posterier p(z_i|x)
%   llh: loglikelihood or evidence lnp(x)
% written by Mo Chen sth4nth@gmail.com
    n = size(x,2);
    [k,d] = size(E);
    X = sparse(x,1:n,1,d,n);
    M = full(E*X);
    
    At = A';
    c = zeros(1,n); % normalization constant
    gamma = zeros(k,n);
    [gamma(:,1),c(1)] = nml(s.*M(:,1),1);
    for i = 2:n
        [gamma(:,i),c(i)] = nml((At*gamma(:,i-1)).*M(:,i),1);  % 13.59
    end
   
    for i = n-1:-1:1
        gamma(:,i) = nml(bsxfun(@times,A,gamma(:,i)),1)*gamma(:,i+1);
    end
    llh = sum(log(c));
end

