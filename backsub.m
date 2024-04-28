function [X] = backsub(A, B, type)
%BACKSUB Backward substitution.
%   The function BACKSUB performs backward substitution for AX = B, where 
%   A, B and X are matrixes and A is triangular.
%
%   X = backsub(A, B, type) returns the solution matrix X, type can takes
%   values:
%       'lower' when A is lower triangular
%       'upper' when A is upper triangular

[n, m] = size(B);
X = zeros(n, m);

switch type
    case 'lower'
        for k=1:n
            X(k, :) = (B(k, :) - A(k, 1:k-1) * X(1:k-1, :)) / A(k, k);
        end
    case 'upper'
        for k=n:-1:1
            X(k, :) = (B(k, :) - A(k, k+1:n) * X(k+1:n)) / A(k, k);
        end
end

end