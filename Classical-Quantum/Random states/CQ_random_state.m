function [c, g, iter, state] = CQ_random_state(adaptive)

%Generate quantum enesemble 
load CQ_random_state_sigmas.mat %Stores pdim and dim
%Acceleration parameter
gamma = 1; %eta = 0.1

%Channel Kraus operators
channelKraus = {};
channelKraus{1} = eye(dim, dim);

%Input distribution and quantum ensemble
lambda_1 = ones(pdim, 1)/pdim;
lambda_1 = lambda_1/sum(lambda_1);
Nsigma = sigma_matrices;

%Iterative steps
tol = 1e-6;
lambda_prev = lambda_1;
delta_prev = findDelta(lambda_prev, sigma_matrices);
Ndelta_prev = applychan(channelKraus, delta_prev, 'kraus');
capacity_prev = findCapacity_CQ(lambda_prev, Nsigma, Ndelta_prev);
convergence = 0;

counter = 1;
while ~convergence 
    for i = 1:pdim
        lambda_curr(i) = lambda_prev(i)*exp(1/gamma*quantum_rel_entr(Nsigma{i}, Ndelta_prev));
    end
    lambda_curr = lambda_curr/sum(lambda_curr);
    delta_curr = findDelta(lambda_curr, sigma_matrices);
    Ndelta_curr = applychan(channelKraus, delta_curr, 'kraus');
    capacity_curr = findCapacity_CQ(lambda_curr, Nsigma, Ndelta_curr);
    convergence = cq_convergence_test(capacity_curr, lambda_curr, Nsigma, Ndelta_curr, tol); 
    if adaptive
        gamma = quantum_rel_entr(Ndelta_curr, Ndelta_prev)/quantum_rel_entr(diag(lambda_curr),diag(lambda_prev)); %Adaptive step size
        gamma(isnan(gamma)) = 1;
        gamma(isinf(gamma)) = 1;
        gamma(gamma==0) = 1;
    end
    
    c(counter) = capacity_curr;
    g(counter) = gamma;
    iter(counter) = counter;
    state{counter} = lambda_curr;
    
    lambda_prev = lambda_curr;
    delta_prev = delta_curr;
    Ndelta_prev = Ndelta_curr;
    capacity_prev = capacity_curr; 
    counter = counter + 1;
end

% If we have qubits, we can calculate the true capacity
% olap = sqrt(trace(sigma_matrices{1}*sigma_matrices{2}));
% true_capacity = quantum_entr(diag([(1+olap)/2;(1 - (1+olap)/2)]));



