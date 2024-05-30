% Author: Mikołaj Jędrzejewski
%
% TEST_PROGRAM Tests the correctness of the method implementation to the problem of solving systems of linear equations AX = B by comparing to Matlab built-in solution.
%
%   Input:
%   - A, matrix of size n by n
%   - X, matrix of size n by m
%   - B, matrix of size n by m
%
%   Output:
%   - errors, vector of errors: for the custom and MATLAB solutions,
%   difference between them and error for determinant
%   - solutions, structure containing the solutions and determinants

function [errors, solutions] = test_program(A, X, B)
    [X_1, det1] = solve(A, B);
    [X_2, det2] = solve_matlab(A, B);
    
    % Define metrics to check correctness
    errors = [  mean(abs(X_1 - X), 'all'), 
                mean(abs(X_2 - X), 'all'), 
                mean(abs(X_1 - X_2), 'all'), 
                abs(det1 - det2)];               

    % Structure to hold the solutions
    solutions.X_1 = X_1;
    solutions.det1 = det1;
    solutions.X_2 = X_2;
    solutions.det2 = det2;
end