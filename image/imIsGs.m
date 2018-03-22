function z = imIsGs(J, h, epoch)
% Gibss sampling for 2d Ising model
% Written by Mo Chen (sth4nth@gmail.com)
[m,n] = size(h);
stride = [-1,1,-m,m];
z = sign(h);
for t = 1:epoch
    for j = 1:n
        for i = 1:m
            pos = i + m*(j-1);
            ne = pos + stride;
            ne([i,i,j,j] == [1,m,1,n]) = [];
            theta = J*sum(z(ne)) + h(i,j);
            z(i,j) = sign(sigmoid(2*theta)-rand);
        end
    end
end 
