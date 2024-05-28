%Author: Mikołaj Jędrzejewski
%
%PLOT_ERROR Plots the solution error and determinant error for
%solving systems of linear equations AX = B with respect to the size of A.
%
%   The matrix A has the form A = [ A_11 A_12 ; 
%                                   A_21 A_22 ] where
%       - each matrix A_ij is of size p by p and n = 2p
%       - A_11 is lower triangular 
%       - A_12 = 0
%       - A_22 is upper triangular
%
%   Input:
%   - a, natural number greater than 1
%   - b, natural number greater than a
%   - show_method_errors, true if method errors should be plotted
function plot_error(a, b, show_method_errors)
    if nargin < 3
        show_method_errors = false;
    end

    t = floor((b - a) / 2) + 1; 
    errors = zeros(t, 4);
    conds = zeros(t, 1);
    method_err_1 = zeros(t, 3); % custom method errors
    method_err_2 = zeros(t, 3); % MATLAB method errors
    for i = 1:t
        n = a + 2 * (i - 1);
        m = n / 2;

        [A, X, B] = generate_case(n, m, 'normal', false);  

        [e, s] = test_program(A, X, B);
        errors(i, 1) = e(1);
        errors(i, 2) = e(2);
        errors(i, 3) = e(3);
        errors(i, 4) = e(4);
            
        conds(i) = cond(X);
        [method_err_1(i, 1), method_err_1(i, 2), method_err_1(i, 3)] = test_method(A, s.X_1, B, X);
        [method_err_2(i, 1), method_err_2(i, 2), method_err_2(i, 3)] = test_method(A, s.X_2, B, X);
    end

    % x-axis values
    n_values = a:2:b; 

    % Plot the solution error
    figure;
    hold on; 
    semilogy(n_values, errors(:, 1), 'r', 'DisplayName', 'Custom solution error');
    semilogy(n_values, errors(:, 2), 'b', 'DisplayName', 'MATLAB solution error');
    hold off;

    title('Solution Errors');
    xlabel('number of matrix rows n');
    ylabel('error value');
    legend show; 
    grid on;
    set(gca, 'YScale', 'log');

    % Plot the determinant error
    figure;
    hold on;
    semilogy(n_values, errors(:, 4), 'r', 'DisplayName', 'Determinant error');
    hold off;

    title('Determinant Error');
    xlabel('number of matrix rows n');
    ylabel('error value');
    legend show;
    grid on;
    set(gca, 'YScale', 'log');

    if show_method_errors
        figure;

        subplot(4,1,1);
        semilogy(n_values, conds(:), 'r', 'DisplayName', 'Condition number');
        hold on;
        hold off;
        legend('Location', 'northwest');
        title('Condition number');
        xlabel('number of matrix rows n');
        ylabel('Value');
        grid on;    


        % Plot relative error
        subplot(4,1,2);
        semilogy(n_values, method_err_1(:, 1), 'r', 'DisplayName', 'Custom solution');
        hold on;
        semilogy(n_values, method_err_2(:, 1), 'b', 'DisplayName', 'MATLAB solution');
        hold off;
        legend('Location', 'northwest');
        title('Relative Error');
        xlabel('Number of matrix rows n');
        ylabel('Error value');
        grid on;
    
        % Plot forward stability error
        subplot(4,1,3);
        semilogy(n_values, method_err_1(:, 2), 'r', 'DisplayName', 'Custom solution');
        hold on;
        semilogy(n_values, method_err_2(:, 2), 'b', 'DisplayName', 'MATLAB solution');
        hold off;
        legend('Location', 'northwest');
        title('Forward Stability Error');
        xlabel('Number of matrix rows n');
        ylabel('Error value');
        grid on;
    
        % Plot backward stability error
        subplot(4,1,4);
        semilogy(n_values, method_err_1(:, 3), 'r', 'DisplayName', 'Custom solution');
        hold on;
        semilogy(n_values, method_err_2(:, 3), 'b', 'DisplayName', 'MATLAB solution');
        hold off;
        legend('Location', 'northwest');
        title('Backward Stability Error');
        xlabel('Number of matrix rows n');
        ylabel('Error value');
        grid on;
    end
end
