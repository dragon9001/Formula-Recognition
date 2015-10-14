function BoxSymbolMap = WordSymbolMapThisLine(SymbolBounds,WordBounds)
%% GetBoxSymbolMap.
%Intput WordBounds:4*n Matrix. SymbolBounds: 4*k Matrix;
%Output 2*n Matrix,each column is the start and end Symbol position of Box


n = size(WordBounds,2);
k = size(SymbolBounds,2);

BoxSymbolMap = zeros(2,n);

lp = SymbolBounds(3,1); 
rp = SymbolBounds(4,1);

for i = 1:n
    j = 0;
    while rp ~= WordBounds(4,i)
        rp = SymbolBounds(4,j+1);
        j = j + 1;
    end
    if lp == WordBounds(3,i) & rp == WordBounds(4,i)
        BoxSymbolMap(:,i) = [lp;rp];   %record This WordSymbol Map
        if i < n
            lp = WordBounds(3,i+1);
            rp = WordBounds(4,i+1);
        else
            return;
        end
    else
        error('error in WordSymbolMapThisLine()');
    end
end


end