function converged = cq_convergence_test(capacity_curr, lambda_curr, Nsigma, Ndelta_curr, tol)
converged = 0;
for i = 1:length(lambda_curr)
    if lambda_curr(i) == 0
        M(i) = NaN;
    else
        M(i) = -quantum_entr(Nsigma{i}) - trace(Nsigma{i}*logMod(Ndelta_curr));
    end
end

if max(M) - capacity_curr <= tol
    converged = 1;
end
