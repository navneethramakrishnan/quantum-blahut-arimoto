function[c,iter,state] = bipartite_CI(input_dim, Q, adaptive)

%Input distribution and quantum ensemble
%p_1 = 1/input_dim*ones(input_dim, 1);
p_1 = [0.3;0.7];
gamma = 1;

%Iterative steps
tol = 1e-6;
p_prev = p_1;
p_curr = p_prev;

capacity_prev = 0;
convergence = 0;
counter = 1;

q_prev = Q*p_prev;



while ~convergence 
    for i = 1: input_dim
        p_curr(i) = p_prev(i)*2^(sum(rel_entr(Q(:,i),q_prev))/(gamma*log(2)));
    end
    p_curr = p_curr/sum(p_curr);
    q_curr = Q*p_curr;

    capacity_curr = findCapacity_bipartite(p_curr, Q);
    
    for i = 1:input_dim
        alpha(i) = sum(Q(:,i).*log(Q(:,i))/log(2)) - sum(Q(:,i).*log(q_curr(:))/log(2));
    end
    alpha_max = max(alpha);

    convergence = (abs(alpha_max - capacity_curr) < tol);
    
    if adaptive
        gamma = quantum_rel_entr(diag(Q*p_curr), diag(Q*p_prev))/quantum_rel_entr(diag(p_curr),diag(p_prev)); %Adaptive step size
        gamma(isnan(gamma)) = 1;
        gamma(isinf(gamma)) = 1;
        gamma(gamma==0) = 1;
    end

    c(counter) = capacity_curr;
    iter(counter) = counter;
    state{counter} = p_curr;
    
    p_prev = p_curr;
    q_prev = q_curr;
    capacity_prev = capacity_curr;
    counter = counter + 1;
end