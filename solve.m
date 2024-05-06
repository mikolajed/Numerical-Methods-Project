%Author: Mikołaj Jędrzejewski
%
%SOLVE Solves systems of linear equations AX = B and computes the determinant of A. 
%
%   Input:
%   - A, matrix of size n by n
%   - B, matrix of size n by m
%
%   The matrix A has the form A = [ A_11 A_12 ; A_21 A_22 ] where
%       - each matrix A_ij is of size p by p and n = 2p
%       - A_11 is lower triangular 
%       - A_12 = 0
%       - A_22 is upper triangular
%
%   Output:
%   - X, matrix of size n by m
%   - d, a real number
%
%   [X, d] = SOLVE(A, B)  returns:  X, the solution matrix of systems of linear equations AX = B
%                                   d, the determinant of A
function [X, d] = solve(A, B)
[n, m] = size(B);
p = n / 2;

% Extract blocks
A_11 = A(1:p, 1:p);
A_21 = A(p+1:2*p, 1:p);
A_22 = A(p+1:2*p, p+1:2*p);

% Compute first p x's by backward substitution
X_1 = backsub(A_11, B(1:p), 'lower');
% Use the first p x's to compute the other half of x's with backward substitution
X_2 = backsub(A_22, B(p+1:2*p) - A_21 * X_1, 'upper');
% The final answer is the concatenation of the two
X = [X_1 X_2];

% Compute the determinant as a product of the main diagonal,
% since A_11 and A_22 are triangular the method is justified - use Laplace
% expansion
d = 1;
for k=1:n
    d = d * A(k, k);
end

end