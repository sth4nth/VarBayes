function [ m, llh ] = bpHmm( x, s, A, E )
% forward-backward alogrithm for HMM to compute posterior p(z_i|x)
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
    
    c = zeros(1,n); % normalization constant
    At = A';
    epoch = 500;
    m = ones(k,n);
    for t = 1:epoch
        m(:,1) = nml(s.*M(:,1).*m(:,2),1);
        for i = 2:(n-1)
            m(:,2) = nml(At*m(:,i-1).*M(:,i).*m(:,i+1),1);
        end
        [m(:,n), c(i)] = nml(At*m(:,n-1),1);
    end
    llh = sum(log(c));
end
