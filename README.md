# Numerical Methods: Solving Matrix Equations

## Overview
This project solves the matrix equation \(AX = B\), where:
- \(A \in \mathbb{R}^{n \times n}\), \(B \in \mathbb{R}^{n \times m}\).
- \(A\) has a block form:
  \[
  A =
  \begin{pmatrix}
  A_{11} & 0 \\
  A_{21} & A_{22}
  \end{pmatrix},
  \]
  where \(A_{11}\) is lower triangular and \(A_{22}\) is upper triangular.

The main tasks include:
1. Solving \(AX = B\) using forward and backward substitution.
2. Calculating the determinant of \(A\) efficiently.

## Methods
### 1. Solving Systems of Linear Equations
The equation is divided into two parts:
- Solve \(A_{11}X_1 = B_1\) using forward substitution.
- Solve \(A_{22}X_2 = B_2 - A_{21}X_1\) using backward substitution.

### 2. Determinant Calculation
The determinant of \(A\) is calculated as:
\[
\text{det}(A) = \prod_{i=1}^{n} A(i, i),
\]
leveraging Laplace expansion along rows/columns with only one non-zero element.

## Implementation
The project is implemented in MATLAB with the following files:
- **`solve.m`**: Custom solver for \(AX = B\).
- **`solve_matlab.m`**: Solver using MATLAB's built-in functions.
- **`substitute.m`**: Implements forward and backward substitution.
- **`generate_case.m`**: Generates test cases.
- **`test_method.m`**: Analyzes solution limitations and errors.
- **`test_program.m`**: Compares custom and MATLAB solutions.
- **`plot_time.m`**: Plots runtime vs. matrix size.
- **`plot_error.m`**: Plots error trends for various matrix sizes.
- **`plot_method_error.m`**: Analyzes method-specific errors.
- **`test.m`**: Visualizes custom solution accuracy.

## Error Metrics
The correctness of solutions is evaluated using:
- **Relative error**: \( \frac{\| X - \hat{X} \|}{\| X \|} \)
- **Forward stability error**: \( \frac{\| X - \hat{X} \|}{\| X \| \cdot \text{cond}(A)} \)
- **Residual error**: \( \frac{\| B - AX \|}{\| A \| \cdot \| X \|} \)

## Results
### Simple Examples
- Provided examples show the custom solution matches MATLAB for small \(n\).
- Determinants for large matrices demonstrate numerical instability.

### Performance
- Custom solution performs faster for small systems.
- MATLAB's built-in functions are faster for large systems (\(m \propto n\)).

### Limitations
- Errors grow exponentially for ill-conditioned or non-diagonally dominant matrices.
- Determinant calculation is numerically unstable for large matrices.

## Visualizations
The project provides:
- Accuracy comparison plots for \(AX = B\).
- Runtime analysis for small and large systems.
- Determinant error trends.

## Conclusion
The custom method is:
- Accurate and numerically stable for small problems.
- Outperformed by MATLAB for large-scale computations due to runtime spikes and numerical instability in determinant calculations.

## References
- W. Cheney, D. Kincaid. *Numerical Analysis: Mathematics of Scientific Computing, 3rd Edition*. American Mathematical Society, 2002.

---

### Getting Started
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/matrix-solver.git
