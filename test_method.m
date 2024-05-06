%Author: Mikołaj Jędrzejewski
%
%TEST_METHOD Tests the limitations of a method to the problem of solving systems of linear equations AX = B by providing error metrics.
%
%   Input:
%   - A, matrix of size n by n
%   - B, matrix of size n by m
%   - X, matrix of size n by m, the exact solution
%   - Z, matrix of size n by m, the solution of a method
%
%   Output:
%   - error1, the relative error
%   - error2, the forward stability error
%   - r_R, the backward stability error (right residual error)
function [error1, error2, r_R] = test_method(A, Z, B, X)

error1 = norm(Z - X) / norm(X);
error2 = error1 / cond(A);
r_R = norm(B - A * Z) / (norm(A) * norm(Z));

end