function N = frobeniusNorm(A, B)
    N = norm(A - B, 'fro');