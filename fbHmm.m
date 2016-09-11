function [ gamma, llh ] = fbHmm( x, s, A, E )
% forward-backward alogrithm for HMM to compute posterior p(z_i|x)
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
    alpha = zeros(k,n);
    [alpha(:,1),c(1)] = nml(s.*M(:,1),1);
    for i = 2:n
        [alpha(:,i),c(i)] = nml((At*alpha(:,i-1)).*M(:,i),1);  % 13.59
    end
    beta = ones(k,n);
    for i = n-1:-1:1
        beta(:,i) = A*(beta(:,i+1).*M(:,i+1))/c(i+1);   % 13.62
    end
    gamma = alpha.*beta;                  % 13.64
    llh = sum(log(c));
end

