%Author: Mikołaj Jędrzejewski
%
%PLOT_TIME Plots execution time of the custom and MATLAB methods for
%solving systems of linear equations AX = B wrt size of A.
%
%   The matrix A has the form A = [ A_11 A_12 ; 
%                                   A_21 A_22 ] where
%       - each matrix A_ij is of size p by p and n = 2p
%       - A_11 is lower triangular 
%       - A_12 = 0
%       - A_22 is upper triangular
%
%   Input:
%   - a, natural number greater than greater than 1
%   - b, natural number greater than a
function plot_time(a, b)
    t = floor((b - a) / 2) + 1;  % number of data cases 
    times_custom = zeros(1, t);  % Array to store execution times for custom solve
    times_matlab = zeros(1, t);  % Array to store execution times for MATLAB solve

    for i = 1:t
        n = a + 2 * (i - 1);
        m = 2 * n;

        [A, X, B] = generate_case(n, m, 'normal', true);     

        % Measure time for custom solve method
        tic;
        [Z_1, det_1] = solve(A, B);
        times_custom(i) = toc / m;

        % Measure time for MATLAB solve method
        tic;
        [Z_2, det_2] = solve_matlab(A, B);
        times_matlab(i) = toc / m;
    end

    % x-axis values
    n_values = a:2:b; 

    % Plot execution time for custom solve method and MATLAB solve method
    figure;
    hold on;
    plot(n_values, times_custom, 'r-', 'DisplayName', 'Custom solution time');
    plot(n_values, times_matlab, 'b-', 'DisplayName', 'MATLAB solution time');
    hold off;

    title('Avg Execution Time Per System');
    xlabel('number of matrix rows n');
    ylabel('Time (seconds)');
    legend('Location', 'northwest');
    grid on;
end
