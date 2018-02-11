function z = imIsGs(J, h, epoch)
% Ising image Gibss sampling
% Written by Mo Chen (sth4nth@gmail.com)
[m,n] = size(h);
stride = [-1,1,-m,m];
z =  h;
for t = 1:epoch
    for j = 1:n
        for i = 1:m
            pos = i + m*(j-1);
            ne = pos + stride;
            ne([i,i,j,j] == [1,m,1,n]) = [];
            z(i,j) = randis(tanh(J*sum(z(ne)) + h(i,j)));
        end
    end
end 

function z = randis(mu)
% rand sample from Ising distribution
z = sign(2*rand-1-mu);