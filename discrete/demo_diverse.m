% example that BP does not converge
n = 3;
A = zeros(n,n);
A(1,2) = 1;
A(2,3) = 2;
A(3,1) = 3;
A = A+A';
