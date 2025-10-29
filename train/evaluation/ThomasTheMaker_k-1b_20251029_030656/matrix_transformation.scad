module matrix_multiply(A, B) {
    if (A.rows != B.cols) {
        raise ValueError("Matrices cannot be multiplied due to incompatible dimensions.");
    }
    return A * B;
}

// Example usage:
//  A = [[1, 2], [3, 4]];
//  B = [[5, 6], [7, 8]];
matrix_multiply(A, B);