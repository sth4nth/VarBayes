function mu = imIsMeanField0(J, h, epoch)
% Ising image mean field (pad image with 0)\
% Written by Mo Chen (sth4nth@gmail.com)
mu = zeros(size(h)+2);                        % padding
[m,n] = size(mu);
stride = [-1,1,-m,m];
mu(2:m-1,2:n-1) = tanh(h);               % init
for t = 1:epoch
    for j = 2:n-1
        for i = 2:m-1
            ne = i + m*(j-1) + stride;
            mu(i,j) = tanh(J*sum(mu(ne))+h(i-1,j-1));
        end
    end
end
mu = mu(2:m-1,2:n-1);