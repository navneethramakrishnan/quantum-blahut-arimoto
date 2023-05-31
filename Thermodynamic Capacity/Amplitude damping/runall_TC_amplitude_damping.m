clear all

adaptive = 0;
[capacity, gamma, iter, state] = TC_amplitude_damping(adaptive);
adaptive = 1;
[acc_capacity, acc_gamma, acc_iter, acc_state] = TC_amplitude_damping(adaptive);
save data_TC_amplitude_damping.mat

plot_TC_amplitude_damping
plot_TC_amplitude_damping_2