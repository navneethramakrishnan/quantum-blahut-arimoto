function[krausOperators] = complementDepolarizingKraus(p)

ChoiMatrix = kron(complementDepolarizingMap(1/2, 0, 0, 1/2, p), [1,0;0,0]) + kron(complementDepolarizingMap(0, 1/2, 1i/2, 0, p), [0,1;0,0])...
    + kron(complementDepolarizingMap(0, 1/2, -1i/2, 0, p), [0,0;1,0]) + kron(complementDepolarizingMap(1/2, 0, 0, -1/2, p), [0,0;0,1]);

[P, Q] = eig(ChoiMatrix);
krausOperators = {};
j = 1;
for i = 1:length(P)
    krausOperators{j} = sqrt(Q(i,i))*[P(1:2, i)'; P(3:4, i)'; P(5:6, i)'; P(7:8, i)'];
    j = j + 1;
end
