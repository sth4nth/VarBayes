function mu = meanFieldIsingGrid(J, CPDs, logprobFn, img)
% img should be an m*n  matrix
% CPDs{1}=p(y|s=-1), CPDs{2}=p(y|s=1)
% mu(i,j) = E(S(i,j)|y) where S(i,j) in {-1,1}
% logprobFn is a handle to a function that will be called with
% logprobFn(CPDS{i}, img(:))
maxIter = 10;
[M,N] = size(img);
offState = 1; onState = 2;
logodds = logprobFn(CPDs{onState}, img(:)) - logprobFn(CPDs{offState}, img(:));
mu = 2*sigmoid(reshape(logodds, M, N))-1;
for iter = 1:maxIter
    for ix=1:N
        for iy=1:M
            pos = iy + M*(ix-1);
            ne = pos + [-1,1,-M,M];
            ne([iy==1,iy==M,ix==1,ix==N]) = [];
            mu(pos) = tanh(J*sum(mu(ne)) + 0.5*logodds(pos));
        end
    end
end



