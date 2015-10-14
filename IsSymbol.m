function Flag = IsSymbol(WordBoundVector,SymbolBoundsArray)

Flag = 0;

for i = 1:size(SymbolBoundsArray,2)
    if sum(WordBoundVector == SymbolBoundsArray(:,i)) == 4
        Flag = 1;
        return;
    end
end

return;