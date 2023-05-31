clear all
%Input dimensions
input_dim = 2;

%Channel Kraus operators
delta = 0.3;
Qyzgx = [(1-delta)^2, delta*(1-delta); delta*(1-delta), delta^2; delta^2, (1-delta)*delta; delta*(1-delta), (1-delta)^2];
Qygx = [1-delta, delta; delta, 1-delta];
Qzgx = Qygx^2;

adaptive = 0;
%Bipartite mutual information
[cy,iter_y,~] = bipartite_CI(input_dim, Qygx, adaptive);
[cz,iter_z,~] = bipartite_CI(input_dim, Qzgx, adaptive);

%Tripartite mutual information
[cyz,iter_yz,~] = tripartite_CI(input_dim, Qyzgx, Qygx, Qzgx, adaptive);

adaptive = 1;
%Bipartite mutual information
[acc_cy,acc_iter_y,~] = bipartite_CI(input_dim, Qygx, adaptive);
[acc_cz,acc_iter_z,~] = bipartite_CI(input_dim, Qzgx, adaptive);

%Tripartite mutual information
[acc_cyz,acc_iter_yz,~] = tripartite_CI(input_dim, Qyzgx, Qygx, Qzgx, adaptive);

save degraded_BSC.mat
