function delta = findDelta(lambda, sigma)
delta = 0;
for i = 1:length(lambda)
    delta = delta + sigma{i}*lambda(i);
end