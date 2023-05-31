function capacity = findCapacity_TC(rho, Nrho)
capacity = quantum_entr(rho) - quantum_entr(Nrho);
end