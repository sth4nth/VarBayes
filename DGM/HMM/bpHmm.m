function [ gamma, llh ] = bpHmm( x, s, A, E )
% Belief propagation alogrithm for HMM to compute posterior p(z_i|x)
%   The algorithm maintain two set of messages, forward \Alpha(z) (downward \pi(z) from parents) and
%   backward \Beta(z) (upward \lambda(z) from children). 
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
    
    Alpha = zeros(k,n);
    Beta = zeros(k,n);
    Alpha(:,1) = s;
    Beta(:,n) = 1;
    At = A';
    for i = 2:n
        Alpha(:,i) = At*(Alpha(:,i-1).*M(:,i-1));
    end
    for i = n-1:-1:1
        Beta(:,i) = A*(Beta(:,i+1).*M(:,i+1));
    end
    [gamma, c] = nml(Alpha.*Beta.*M,1);
    llh = mean(log(c));   % all c(i) are equal
end

