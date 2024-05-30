% Author: Mikołaj Jędrzejewski
%
% PLOT_METHOD_ERROR Plots errors for the custom and MATLAB methods for solving systems
% of linear equations AX = B. Errors include: relative error, forward
% stability error, and backward stability error.
%
% Input:
% - a, natural number greater than 1
% - b, natural number greater than a
%
% The function runs tests for randomized matrices A, B. Where n is even
% and on interval [a, b].
function plot_method_error(a, b)
    % Calculate number of cases
    t = floor((b - a) / 2) + 1; 
    % Allocate memory for the three types of errors for both of the methods
    errors = zeros(t, 3);
    errors_m = zeros(t, 3);
    conds = zeros(t, 1);
    for i = 1:t
        n = a + 2 * (i - 1);
        m = 2 * n;

        [A, X, B] = generate_case(n, m, 'normal', true);    

        Z_1 = solve(A, B);
        Z_2 = solve_matlab(A, B);
        
        conds(i) = norm(A) * norm(inv(A));      % or just cond(A);
        [errors(i, 1), errors(i, 2), errors(i, 3)] = test_method(A, Z_1, B, X);
        [errors_m(i, 1), errors_m(i, 2), errors_m(i, 3)] = test_method(A, Z_2, B, X);
    end

    % x-axis values
    n_values = a:2:b; 

    % Plot condition number of matrix X
    figure;
    semilogy(n_values, conds(:), 'r', 'DisplayName', 'Condition number');
    legend('Location', 'northwest');
    title('Condition Number of Matrix X');
    xlabel('number of matrix rows n');
    ylabel('Condition number');
    grid on;

    % Plot relative error
    figure;
    semilogy(n_values, errors(:, 1), 'r', 'DisplayName', 'Custom solution');
    hold on;
    semilogy(n_values, errors_m(:, 1), 'b', 'DisplayName', 'MATLAB solution');
    hold off;
    legend('Location', 'northwest');
    title('Relative Error');
    xlabel('number of matrix rows n');
    ylabel('Relative error');
    grid on;
    
    % Plot forward stability error
    figure;
    semilogy(n_values, errors(:, 2), 'r', 'DisplayName', 'Custom solution');
    hold on;
    semilogy(n_values, errors_m(:, 2), 'b', 'DisplayName', 'MATLAB solution');
    hold off;
    legend('Location', 'northwest');
    title('Forward Stability Error');
    xlabel('number of matrix rows n');
    ylabel('Forward stability error');
    grid on;

    % Plot backward stability error
    figure;
    semilogy(n_values, errors(:, 3), 'r', 'DisplayName', 'Custom solution');
    hold on;
    semilogy(n_values, errors_m(:, 3), 'b', 'DisplayName', 'MATLAB solution');
    hold off;
    legend('Location', 'northwest');
    title('Backward Stability Error');
    xlabel('number of matrix rows n');
    ylabel('Backward stability error');
    grid on;
end