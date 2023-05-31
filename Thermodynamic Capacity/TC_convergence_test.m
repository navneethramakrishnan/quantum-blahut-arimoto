function converged = TC_convergence_test(capacity_curr, rho_curr, adjlogNrho_curr, tol)

converged = 0;
F = -logMod(rho_curr) + adjlogNrho_curr;
eigenvalues = svd(F);

if max(eigenvalues) - capacity_curr <= tol
    converged = 1;
end
