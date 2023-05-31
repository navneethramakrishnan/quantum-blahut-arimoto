function capacity = findCapacity_MI(rho, Nrho, complementNrho)
capacity = VNent(rho)*log(2) + VNent(Nrho)*log(2) - VNent(complementNrho)*log(2);
end
