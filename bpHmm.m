function [ m ] = bpHmm( x, s, A, E )
%BPHMM Summary of this function goes here
%   Detailed explanation goes here
    n = size(x,2);
    [k,d] = size(E);
    X = sparse(x,1:n,1,d,n);
    M = full(E*X);
    
    At = A';
    epoch = 500;
    m = ones(k,n);
    for t = 1:epoch
        m(:,1) = nml(s.*M(:,1).*m(:,2),1);
        for i = 2:(n-1)
            m(:,2) = nml(At*m(:,i-1).*M(:,i).*m(:,i+1),1);
        end
        m(:,n) = nml(At*m(:,n-1),1);
    end
end
