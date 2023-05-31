clear all

adaptive = 0;
[capacity, iter, state, F] = MI_depolarizing(adaptive);
adaptive = 1;
[acc_capacity, acc_iter, acc_state, acc_F] = MI_depolarizing(adaptive);
save data_MI_depolarizing.mat

% plot_MI_depolarizing
% plot_MI_depolarizing_2