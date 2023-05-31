function [tensored_operators] = tensor_operators(set1, set2)

%Given as input two sets of operators, this function outputs a set of operators.
%The output set consists of the tensor product between every element from set 1 with every element from set 2

tensored_operators = {};
for i = 1:length(set1)
    for j = 1:length(set2)
        tensored_operators{end + 1} = kron(set1{i}, set2{j});
    end
end
