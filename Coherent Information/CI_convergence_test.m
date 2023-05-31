function converged = CI_convergence_test(capacity_curr, F, tol)
converged = 0;
if abs(max(eig(F)) - capacity_curr) <= tol 
    converged = 1;
end
