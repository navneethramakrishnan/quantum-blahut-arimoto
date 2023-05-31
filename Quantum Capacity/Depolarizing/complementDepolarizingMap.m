function[M] = complementDepolarizingMap(rhoI, rhoX, rhoY, rhoZ, p) 

% Applies N_c(rho) where rho is written in the Pauli basis with
% coefficients rhoI, rhoX, etc..

dim = 2;
rho = rhoI*full(Pauli(0)) + rhoX*full(Pauli(1)) + rhoY*full(Pauli(2)) + rhoZ*full(Pauli(3));
channelKraus = {};
channelKraus{1} = sqrt(1 - p)*eye(dim);
channelKraus{2} = sqrt(p/3)*full(Pauli(1));
channelKraus{3} = sqrt(p/3)*full(Pauli(2));
channelKraus{4} = sqrt(p/3)*full(Pauli(3));

stinespringDilation = kron(channelKraus{1}, [1;0;0;0]) + kron(channelKraus{2}, [0;1;0;0]) + kron(channelKraus{3}, [0;0;1;0]) + kron(channelKraus{4}, [0;0;0;1]);
M = PartialTrace(stinespringDilation*rho*stinespringDilation', 1, [2, 4]);

