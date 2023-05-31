function adjointKraus = findAdjointChannelKraus(channelKraus)

adjointKraus={};
for i = 1:length(channelKraus)
    adjointKraus{i}=ctranspose(channelKraus{i});
end

end
