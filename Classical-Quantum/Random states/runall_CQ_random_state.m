clear all

%pdim = 1;
%dim = 1;
%sigma_matrices = generateSigmaEnsemble(pdim, dim); %Pure states give the result instantly (except if the intial guess is bad)
%save CQ_random_state_sigmas.mat

adaptive = 0;
[capacity, gamma, iter, state] = CQ_random_state(adaptive);
adaptive = 1;
[acc_capacity, acc_gamma, acc_iter, acc_state] = CQ_random_state(adaptive);

save data_CQ_random_state.mat
plot_CQ_random_state
plot_CQ_random_state_2
