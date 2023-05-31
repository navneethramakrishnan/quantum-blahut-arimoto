function complementChannelKrausOperators = complementKrausFinder(rho_dim, krausOperators)

nKraus = length(krausOperators);
szKraus = size(krausOperators{1});
dim = szKraus(1); %Kraus operator is (m,n) -> dim = m
U = 0;

for i = 1:nKraus
    v = zeros(nKraus, 1);
    v(i) = 1;
    U = U + kron(krausOperators{i}, v);
end

complementChannelChoi = 0;
for i = 1:rho_dim
    for j = 1:rho_dim
        x = zeros(rho_dim, rho_dim);
        x(i,j) = 1; %this is |iXj|
        complementChannelChoi = complementChannelChoi + kron(PartialTrace(U*x*U', 1, [dim, nKraus]), x);
    end
end

[P, Q] = eig(complementChannelChoi);
complementChannelKrausOperators = {};
for i = 1:length(P)
    A = [];
    for j = 1:length(P)/rho_dim
        b = P((j-1)*rho_dim + 1:j*rho_dim, i)';
        A = [A;b];
    end
    if abs(Q(i,i)) > 1e-10  
        complementChannelKrausOperators{end+1} = sqrt(Q(i,i))*A;
    end
end