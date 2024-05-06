%Author: Mikołaj Jędrzejewski
%
%TEST_PROGRAM Tests the correctness of the method implementation to the problem of solving systems of linear equations AX = B by comparing to Matlab built-in solution.
%
%   Input:
%   - A, matrix of size n by n
%   - B, matrix of size n by m
%
%   Output:
%   - err, difference between solutions
function [err] = test_program(A, B)

X_1 = solve(A, B);
X_2 = solve_matlab(A, B);

% Define metric to check correctness
err = sum(sum(abs(X_1 - X_2)));

end