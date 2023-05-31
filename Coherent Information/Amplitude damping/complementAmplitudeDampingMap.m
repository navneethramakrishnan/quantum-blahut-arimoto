function[M] = complementAmplitudeDampingMap(rhoI, rhoX, rhoY, rhoZ, p) 

rho = rhoI*full(Pauli(0)) + rhoX*full(Pauli(1)) + rhoY*full(Pauli(2)) + rhoZ*full(Pauli(3));
channelKraus = {};
channelKraus{1} = sqrt(p)*[0 1; 0 0];
channelKraus{2} = [1 0; 0 0] + sqrt(1-p)*[0 0; 0 1];

stinespringDilation = kron(channelKraus{1}, [1;0]) + kron(channelKraus{2}, [0;1]);
M = PartialTrace(stinespringDilation*rho*stinespringDilation', 1, [2, 2]);

