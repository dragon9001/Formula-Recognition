function resultBinaryMatrix = homogeneousJudge(inputBinaryMatrix)
%%
% this function aims to found if an element in Matrix and one of its
% neibour element is 0, if so ,the result Matrix element at same
% position of input Matrix would be 0,other wise would be 1
%% 边界上偷懒了 记得补回来

resultBinaryMatrix = zeros(size(inputBinaryMatrix));

for i = 2:size(inputBinaryMatrix,1) - 1;
    for j = 2:size(inputBinaryMatrix,2) - 1;
        if(inputBinaryMatrix(i,j)~=0)
            resultBinaryMatrix(i,j) = 1;
        else
            temp = inputBinaryMatrix(i-1,j)+inputBinaryMatrix(i+1,j)+inputBinaryMatrix(i,j-1)+inputBinaryMatrix(i,j+1);
            if(temp>=3)
                resultBinaryMatrix(i,j) = 1;
            end
        end
    end
end

end