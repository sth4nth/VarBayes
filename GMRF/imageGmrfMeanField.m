function mu = imageGmrfMeanField(x, lambda, Lij, Lii, epoch)
% w: L_{ij}
% L: L_{ii}
% l: \lambda 
if nargin < 5
    epoch = 10;
end
[M,N] = size(x);
mu = x;
stride = [-1,1,-M,M];
for t = 1:epoch
    for j = 1:N
        for i = 1:M
            pos = i + M*(j-1);
            ne = pos + stride;
            ne([i,i,j,j] == [1,M,1,N]) = [];
            mu(i,j) = (lambda*x(i,j)-sum(Lij.*mu(ne)))/(lambda+Lii);
        end
    end
end 

