function[c, g, iter, state] = TC_amplitude_damping(adaptive)

%Input dimensions
dim = 2;

%Acceleration parameter
gamma = 1; 

%Channel Kraus operators
p = 0.3;
channelKraus = {};
channelKraus{1} = sqrt(p)*[0 1; 0 0];
channelKraus{2} = [1 0; 0 0] + sqrt(1-p)*[0 0; 0 1];

%calculate adjoint channel
adjointChannelKraus = findAdjointChannelKraus(channelKraus);

%Input distribution and quantum ensemble
rho_1 = eye(dim)*1/dim;

%Iterative steps
tol = 1e-6;
rho_prev = rho_1;
Nrho_prev = applychan(channelKraus, rho_prev, 'kraus');
adjlogNrho_prev = applychan(adjointChannelKraus, logMod(Nrho_prev), 'kraus');
capacity_prev = findCapacity_TC(rho_prev, Nrho_prev);
convergence = 0;

counter = 1;
while ~convergence 
    A = logMod(rho_prev);
    B = -logMod(rho_prev); 
    C = adjlogNrho_prev;
    rho_curr = expm(A + 1/gamma*(B+C));
    rho_curr = rho_curr/trace(rho_curr);
    Nrho_curr = applychan(channelKraus, rho_curr, 'kraus');
    adjlogNrho_curr = applychan(adjointChannelKraus, logMod(Nrho_curr), 'kraus');
    capacity_curr = findCapacity_TC(rho_curr, Nrho_curr);
    convergence = TC_convergence_test(capacity_curr, rho_curr, adjlogNrho_curr, tol); 
    if adaptive 
        gamma = 1 - quantum_rel_entr(Nrho_curr, Nrho_prev)/quantum_rel_entr(rho_curr, rho_prev); %Adaptive step size
        gamma(isnan(gamma)) = 1;
        gamma(gamma==0) = 1;
    end
    
    c(counter) = capacity_curr;
    g(counter) = gamma;
    iter(counter) = counter;
    state{counter} = rho_curr;
    
    rho_prev = rho_curr;
    Nrho_prev = Nrho_curr;
    adjlogNrho_prev = adjlogNrho_curr;
    capacity_prev = capacity_curr; 
    counter = counter + 1;
end

