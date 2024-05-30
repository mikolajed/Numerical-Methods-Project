%Author: Mikołaj Jędrzejewski
%
%GENERATE_CASE Generates matrices A, X and B that satisfy systms of linear equations AX = B.
%
%   The matrix A has the form A = [ A_11 A_12 ; 
%                                   A_21 A_22 ] where
%       - each matrix A_ij is of size p by p and n = 2p
%       - A_11 is lower triangular 
%       - A_12 = 0
%       - A_22 is upper triangular
%
%   Input:
%   - n, natural number greater than 1
%   - m, natural number
%   - type, indicates the distirbution of entires of the matrices should
%           take, options include: 
%               - 'normal' for standard normal distribution
%               - 'uniform' for uniform distribution on interval [0, 1]
%               - 'natural' for integers
%
%   The function runs tests for randomized matrices A, B. Where n is even
%   and on interval [a, b].
function [A, X, B] = generate_case(n, m, type, make_diag_dom)
    if nargin < 4
        make_diag_dom = false;
    end

    % Define the matrix generation function based on the type, 
    % params a and b indicate the size of the output matrix
    switch type
        case 'normal'
            f = @(a, b) randn(a, b);
        case 'uniform'
            f = @(a, b) -1e6 + 1e6 * rand(a, b);
        case 'natural'
            f = @(a, b) randi([0, 10], a, b) + 1;
        otherwise
            error('Unsupported type. Choose from ''normal'', ''uniform'', or ''natural''.');
    end

    % Generate the submatrices with the specified structure using the chosen distribution
    A_11 = tril(f(floor(n/2), floor(n/2)));
    A_12 = zeros(floor(n/2), ceil(n/2));
    A_22 = triu(f(ceil(n/2), ceil(n/2)));
    A_21 = f(ceil(n/2), floor(n/2));

    % Combine the submatrices to form A
    A = [A_11, A_12;
         A_21, A_22];

    % Make A diagonally dominant if required
    if make_diag_dom
        for i = 1:n
            row_sum = sum(abs(A(i, :))) - abs(A(i, i));
            % Ensure diagonal element is greater than row_sum
            if A(i, i) <= row_sum
                A(i, i) = row_sum + 0.1;
            end
        end
    end

    % Generate X and compute B
    X = f(n, m); 
    B = A * X;   
end
