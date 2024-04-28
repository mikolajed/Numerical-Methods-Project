function [X, det] = solve(A, B)
%SOLVE Solves systems of linear equations AX = B and computes determinant
%of A. 
%
%   The matrix A is of the form A = [ A_11 A_12 ; A_21 A_22 ] where
%       A_11 is lower triangular 
%       A_12 = 0
%       A_22 is upper triangular
%
%   [X, det] = SOLVE(A, B)  returns:    X, the solution matrix of systems of linear equations AX = B
%                                       det, the determinant of A


[n, m] = size(B);
p = n / 2;

A_11 = A(1:p, 1:p);
A_21 = A(p+1:2*p, 1:p);
A_22 = A(p+1:2*p, p+1:2*p);
X_1 = backsub(A_11, B, 'lower');
X_2 = backsub(A_22, B - A_21 * X_1, 'upper');
X = [X_1 X_2];

% Compute the determinant as a product of the main diagonal
det = 1;
for k=1:n
    det = det * A(k, k);
end

end