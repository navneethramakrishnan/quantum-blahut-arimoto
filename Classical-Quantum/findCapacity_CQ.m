function capacity = findCapacity_CQ(lambda, Nsigma, Ndelta)
    capacity = quantum_entr(Ndelta);
    for i = 1:length(lambda)
        capacity = capacity - lambda(i)*quantum_entr(Nsigma{i});
    end
end