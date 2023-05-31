clear all

adaptive = 0;
[capacity, iter, state, F] = MI_amplitude_damping(adaptive);
adaptive = 1;
[acc_capacity, acc_iter, acc_state, acc_F] = MI_amplitude_damping(adaptive);
save data_MI_amplitude_damping.mat

plot_MI_amplitude_damping
plot_MI_amplitude_damping_2