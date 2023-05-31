function sigma = generateSigmaEnsemble(pdim, dim)
sigma = {};
for i = 1: pdim
    sigma{i} = RandomDensityMatrix(dim, dim);
end

