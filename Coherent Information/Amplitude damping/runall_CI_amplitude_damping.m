clear all

adaptive = 0;
[capacity, iter, state, F] = CI_amplitude_damping(adaptive);
adaptive = 1;
[acc_capacity, acc_iter, acc_state, acc_F] = CI_amplitude_damping(adaptive);
save data_CI_amplitude_damping.mat

plot_CI_amplitude_damping
plot_CI_amplitude_damping_2