function[c,iter,state] = tripartite_CI(input_dim, Qyzgx, Qygx, Qzgx, adaptive)

%Input distribution and quantum ensemble
%p_1 = 1/input_dim*ones(input_dim, 1);
p_1 = [0.3;0.7];
gamma = 1;


%Iterative steps
tol = 1e-6;
px_prev = p_1;
px_curr = px_prev;

capacity_prev = 0;
convergence = 0;
counter = 1;

qy_prev = Qygx*px_prev;
qz_prev = Qzgx*px_prev;
qyz_prev = Qyzgx*px_prev;

while ~convergence 
    for i = 1: input_dim
        px_curr(i) = px_prev(i)*2^(sum(rel_entr(Qyzgx(:,i),kron(qy_prev, qz_prev)))/(2*gamma*log(2)));
    end
    px_curr = px_curr/sum(px_curr);
    qy_curr = Qygx*px_curr;
    qz_curr = Qzgx*px_curr;
    qyz_curr = Qyzgx*px_curr;

    capacity_curr = findCapacity_tripartite(px_curr, Qyzgx, Qygx, Qzgx);
    for i = 1:input_dim
        alpha(i) = sum(Qyzgx(:,i).*log(Qyzgx(:,i))/log(2)) - sum(Qygx(:,i).*log(qy_curr(:))/log(2)) - sum(Qzgx(:,i).*log(qz_curr(:))/log(2));
    end
    alpha_max = max(alpha);

    convergence = (abs(alpha_max - capacity_curr) < tol);

    if adaptive
        gamma = quantum_rel_entr(diag(Qyzgx*px_curr), diag(Qyzgx*px_prev))/quantum_rel_entr(diag(px_curr),diag(px_prev)); %Adaptive step size
        gamma(isnan(gamma)) = 1;
        gamma(isinf(gamma)) = 1;
        gamma(gamma==0) = 1;
    end
    
    c(counter) = capacity_curr;
    iter(counter) = counter;
    state{counter} = px_curr;
    
    px_prev = px_curr;
    qy_prev = qy_curr;
    qz_prev = qz_curr;
    qyz_prev = qyz_curr;
    capacity_prev = capacity_curr;
    counter = counter + 1;
end