function[c,iter,state,F] = MI_depolarizing(adaptive)
%Input dimensions
dim = 2;

%Acceleration parameter
gamma = 1; 

%Channel Kraus operators
p = 0.75; %See arxiv 1510.01366 (10). p is \epsilon, not \eta and goes from 0 to 0.75. 
channelKraus = {};
channelKraus{1} = sqrt(1 - p)*eye(dim);
channelKraus{2} = sqrt(p/3)*full(Pauli(1));
channelKraus{3} = sqrt(p/3)*full(Pauli(2));
channelKraus{4} = sqrt(p/3)*full(Pauli(3));

%calculate complementary channel
complementChannelKraus = complementDepolarizingKraus(p);

%calculate adjoint channel
adjointChannelKraus = findAdjointChannelKraus(channelKraus);
adjointComplementChannelKraus = findAdjointChannelKraus(complementChannelKraus);

%Input distribution and quantum ensemble
rho_1 = eye(dim)*1/dim;

%Iterative steps
tol = 1e-6;
rho_prev = full(rho_1);
Nrho_prev = applychan(channelKraus, rho_prev, 'kraus');
complementNrho_prev = applychan(complementChannelKraus, rho_prev, 'kraus');
adjlogNrho_prev = applychan(adjointChannelKraus, logMod(Nrho_prev), 'kraus');
adjlogcomplementNrho_prev = applychan(adjointComplementChannelKraus, logMod(complementNrho_prev), 'kraus');

capacity_prev = findCapacity_MI(rho_prev, Nrho_prev, complementNrho_prev);
convergence = 0;
counter = 1;

while ~convergence && counter < 1000 
    A = logMod(rho_prev);
    B = adjlogNrho_prev; 
    C = adjlogcomplementNrho_prev;
    rho_curr = expm(A + 1/gamma*(-A + C - B));
    rho_curr = rho_curr/trace(rho_curr);
    
    Nrho_curr = applychan(channelKraus, rho_curr, 'kraus');
    adjlogNrho_curr = applychan(adjointChannelKraus, logMod(Nrho_curr), 'kraus');
    complementNrho_curr = applychan(complementChannelKraus, rho_curr, 'kraus');
    adjlogcomplementNrho_curr = applychan(adjointComplementChannelKraus, logMod(complementNrho_curr), 'kraus');
    
    capacity_curr = findCapacity_MI(rho_curr, Nrho_curr, complementNrho_curr);
    convergence = MI_convergence_test(capacity_curr, -A + C -B, tol);
    if adaptive 
        gamma = (quantum_rel_entr(rho_curr, rho_prev)+ quantum_rel_entr(Nrho_curr, Nrho_prev) - quantum_rel_entr(complementNrho_curr, complementNrho_prev))/quantum_rel_entr(rho_curr, rho_prev); %Adaptive step size
        gamma(isnan(gamma)) = 1;
        gamma(gamma==0) = 1;
    end
    
    c(counter) = capacity_curr;
    iter(counter) = counter;
    state{counter} = rho_curr;
    F{counter} = logMod(rho_curr) + adjlogcomplementNrho_curr - adjlogNrho_curr;
    
    rho_prev = rho_curr;
    Nrho_prev = Nrho_curr;
    complementNrho_prev = complementNrho_curr;
    adjlogNrho_prev = adjlogNrho_curr;
    adjlogcomplementNrho_prev = adjlogcomplementNrho_curr;
    capacity_prev = capacity_curr;
    counter = counter + 1;
end