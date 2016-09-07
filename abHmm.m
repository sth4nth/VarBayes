function [alpha, beta, gamma, c] = abHmm(x, s, A, E)
%FWDBWD Summary of this function goes here
%   Detailed explanation goes here
    n = size(x,2);
    d = max(x);
    X = sparse(x,1:n,1,d,n);
    M = E*X;
    
    [K,T] = size(M);
    At = A';
    c = zeros(1,T); % normalization constant
    alpha = zeros(K,T);
    [alpha(:,1),c(1)] = nml(s.*M(:,1),1);
    for t = 2:T
        [alpha(:,t),c(t)] = nml((At*alpha(:,t-1)).*M(:,t),1);  % 13.59
    end
    beta = ones(K,T);
    for t = T-1:-1:1
        beta(:,t) = A*(beta(:,t+1).*M(:,t+1))/c(t+1);   % 13.62
    end
    gamma = alpha.*beta;                  % 13.64
end

