function capacity = findCapacity_CI(Nrho, complementNrho)
capacity = VNent(Nrho)*log(2) - VNent(complementNrho)*log(2);
end
