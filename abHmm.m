function [ m, llh ] = abHmm( x, s, A, E )
%FWDBWD Summary of this function goes here
%   Detailed explanation goes here
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
    m = alpha.*beta;                  % 13.64
    llh = sum(log(c));
end

