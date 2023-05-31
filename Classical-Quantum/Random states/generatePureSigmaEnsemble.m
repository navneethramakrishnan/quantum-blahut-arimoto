function sigma = generatePureSigmaEnsemble(pdim, dim)
sigma = {};
for i = 1: pdim
    v = RandomStateVector(dim);
    sigma{i} = v*ctranspose(v);
end
