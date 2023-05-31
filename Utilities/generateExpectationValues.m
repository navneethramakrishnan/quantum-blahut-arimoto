function[expectationValues] = generateExpectationValues(operatorList, rho)

expectationValues = zeros(1, length(operatorList));
for i = 1:length(expectationValues)
    expectationValues(i) = trace(operatorList{i}*rho); %Note that operator list is a cell array, not vector
end


