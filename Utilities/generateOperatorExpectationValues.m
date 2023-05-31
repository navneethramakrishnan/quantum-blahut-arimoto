function error_vec = generateOperatorExpectationValues(rho, trueState, operatorList, nOperators)

for iter_operator = 1:nOperators
    error_vec(iter_operator) = trace(operatorList{iter_operator}*(rho - trueState));
end

%Warning: Do not preallocate error_vec. CVX will not be able to convert to CVX expression