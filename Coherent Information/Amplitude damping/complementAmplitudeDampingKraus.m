function[krausOperators] = complementAmplitudeDampingKraus(p)

ChoiMatrix = kron(complementAmplitudeDampingMap(1/2, 0, 0, 1/2, p), [1,0;0,0]) + kron(complementAmplitudeDampingMap(0, 1/2, 1i/2, 0, p), [0,1;0,0])...
    + kron(complementAmplitudeDampingMap(0, 1/2, -1i/2, 0, p), [0,0;1,0]) + kron(complementAmplitudeDampingMap(1/2, 0, 0, -1/2, p), [0,0;0,1]);

[P, Q] = eig(ChoiMatrix);
krausOperators = {};
j = 1;
for i = 1:length(P)
    if abs(Q(i,i)) > 1e-8  
        krausOperators{j} = sqrt(Q(i,i))*[P(1:2, i)'; P(3:4, i)'];
        j = j + 1;
    end
end
