function mu = imIsMf(J, h, epoch)
% Ising image mean field
% Written by Mo Chen (sth4nth@gmail.com)
[m,n] = size(h);
stride = [-1,1,-m,m];
mu =  tanh(h);
for t = 1:epoch
    for j = 1:n
        for i = 1:m
            pos = i + m*(j-1);
            ne = pos + stride;
            ne([i,i,j,j] == [1,m,1,n]) = [];
            mu(i,j) = tanh(J*sum(mu(ne)) + h(i,j));
        end
    end
end 

