function mu = meanFieldIsingGrid0(logodds, J)
epoch = 10;
[M,N] = size(logodds);
mu = 2*sigmoid(logodds)-1;               % init
for t = 1:epoch
    for i = 1:M
        for j = 1:N
            pos = i + M*(j-1);
            ne = pos + [-1,1,-M,M];
            ne([i,i,j,j] == [1,M,1,N]) = [];
            mu(i,j) = tanh(J*sum(mu(ne)) + 0.5*logodds(i,j));
        end
    end
end