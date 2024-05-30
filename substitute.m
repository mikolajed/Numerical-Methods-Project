% Author: Mikołaj Jędrzejewski
%
%SUBSTITUTE Performs backward or forward substitution for AX = B, where A, B and X are matrixes and A is triangular.
%
%   Input:
%   - A, square triangular matrix of size n by n
%   - B, matrix of size n by m
%   - type takes values:
%       'lower' when A is lower triangular
%       'upper' when A is upper triangular
%
%   Output:
%   - X, matrix of size n by m
%
%   X = SUBSTITUTE(A, B, type) returns:     the solution matrix X of m n-dimensional vectors to m
%                                           systems of linear equations
%   
function [X] = substitute(A, B, type)
[n, m] = size(B);

% Allocate space for the solution matrix
X = zeros(n, m);

switch type
    case 'lower'
        for k=1:n
            if A(k, k) == 0
                error("backsub:zeroDiagonal", "Matrix A has 0 on the main diagonal.");
            end
            X(k, :) = (B(k, :) - A(k, 1:k-1) * X(1:k-1, :)) / A(k, k);
        end
    case 'upper'
        for k=n:-1:1
            if A(k, k) == 0
                error("backsub:zeroDiagonal", "Matrix A has 0 on the main diagonal.");
            end
            X(k, :) = (B(k, :) - A(k, k+1:n) * X(k+1:n, :)) / A(k, k);
        end
end

end