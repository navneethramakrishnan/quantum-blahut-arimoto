function capacity = findCapacity_tripartite(p, Qyzgx, Qygx, Qzgx)
    
    qyz = Qyzgx*p;
    qy = Qygx*p;
    qz = Qzgx*p;
    
    qylqy = qy.*log(qy);
    qzlqz = qz.*log(qz);
    qylqy(isnan(qylqy)) = 0;
    qzlqz(isnan(qzlqz)) = 0;

    QLQ = Qyzgx.*log(Qyzgx)/log(2);
    QLQ(isnan(QLQ))=0;

    for i = 1:size(p)
        cond_entr_term(i) = p(i)*sum(QLQ(:,i));
    end
    
    capacity = -sum(qylqy)/log(2) -sum(qzlqz)/log(2) + sum(cond_entr_term);
end