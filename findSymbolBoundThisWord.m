function SymbolBoundThisWord = findSymbolBoundThisWord(SymbolBounds,SingleWordBound)
%% imput LineSymbols(4*n) and WordBound fot singgle Word
% output a 4*m Matrix indicating SymbolBounds.

n = size(SymbolBounds,2);

l = SingleWordBound(3);
r = SingleWordBound(4);

for i = 1:n
    if SymbolBounds(3,i) == l
        break;
    end
end
SymbolBoundThisWord = SymbolBounds(:,i);

if SymbolBounds(4,i) == r
    return; 
end

for j = i+1:n
    if SymbolBounds(4,j) ~= r
        SymbolBoundThisWord = [SymbolBoundThisWord SymbolBounds(:,j)];
    else
        SymbolBoundThisWord = [SymbolBoundThisWord SymbolBounds(:,j)];
        break;
    end      
end


end