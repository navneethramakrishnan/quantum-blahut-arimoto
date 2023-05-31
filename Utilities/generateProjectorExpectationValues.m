function error_vec = generateProjectorExpectationValues(rho, stateDensityMatrix, projectorList, nOperators, dim)

for iter_op_vec = 1:nOperators
    for iter_dim_vec = 1:dim
        iter_error_vec = iter_dim_vec + (iter_op_vec - 1)*dim;
        error_vec(iter_error_vec) = trace(projectorList{iter_op_vec}(:,iter_dim_vec)*ctranspose(projectorList{iter_op_vec}(:,iter_dim_vec))*(rho - stateDensityMatrix));
    end
end

%Warning: Do not preallocate error_vec. CVX will not be able to convert to CVX expression