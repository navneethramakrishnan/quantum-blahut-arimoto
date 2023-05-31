function capacity = findCapacity_bipartite(p, Q)
    q = Q*p;
    
    qlq = q.*log(q);
    qlq(isnan(qlq)) = 0;

    QLQ = Q.*log(Q)/log(2);
    QLQ(isnan(QLQ))=0;

    for i = 1:size(p)
        cond_entr_term(i) = p(i)*sum(QLQ(:,i));
    end
    
    capacity = -sum(qlq)/log(2) + sum(cond_entr_term);
end


