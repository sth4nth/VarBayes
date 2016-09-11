function [ gamma, llh ] = fbHmm( x, s, A, E )
% forward-backward (recursive gamma no alpha-beta) alogrithm for HMM to compute posterior p(z_i|x)
% Input:
%   x: 1xn observation
%   s: kx1 starting probability of p(z_1|s)
%   A: kxk transition probability
%   E: kxd emission probability
% Output:
%   gamma: 1xn posterier p(z_i|x)
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
%     beta = ones(k,n);
%     for i = n-1:-1:1
%         beta(:,i) = A*(beta(:,i+1).*M(:,i+1))/c(i+1);   % 13.62
%         gamma(:,i) = gamma(:,i).*beta(:,i);
%     end
    for i = n-1:-1:1
        gamma(:,i) = 
    end
    llh = sum(log(c));
end

