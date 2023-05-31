function L = logMod(x)
[P, Q] = eig(x);
for i = 1:min(size(Q))
    Q(i,i) = log(Q(i,i)+(Q(i,i)==0));
end
L = P*Q*P';    
end