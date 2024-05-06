%Author: Mikołaj Jędrzejewski
%
%SOLVE_MATLAB Solves systems of linear equations AX = B and computes the determinant of A using Matlab built-in functions. 
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
%   [X, d] = SOLVE_MATLAB(A, B)  returns:   X, the solution matrix of systems of linear equations AX = B
%                                           d, the determinant of A
function [X, d] = solve_matlab(A, B)
X = B \ A;
d = det(A);

end