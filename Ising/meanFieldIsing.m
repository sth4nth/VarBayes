function mu = meanFieldIsing(logodds, J)
epoch = 10;
mu = zeros(size(logodds)+2);                        % padding
[m,n] = size(mu);
mu(2:m-1,2:n-1) = 2*sigmoid(logodds)-1;               % init
step = [-1,1,-m,m];
for t = 1:epoch
    for i = 2:m-1
        for j = 2:n-1
            ne = i + m*(j-1) + step;
            mu(i,j) = tanh(J*sum(mu(ne)) + 0.5*logodds(i-1,j-1));
        end
    end
end
mu = mu(2:m-1,2:n-1);