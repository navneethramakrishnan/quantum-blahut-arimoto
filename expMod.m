function E = expMod(x)
[P, Q] = eig(x);
for i = 1:min(size(Q))
    Q(i,i) = exp(Q(i,i));
end
E = P*Q*P';    
end