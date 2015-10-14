function BoxSymbolMap = WordSymbolMap(SymbolBounds,WordBounds);
%% This function 
% input WordBounds and SymbolBounds
% output:
% BoxSymbolMap --- a 1*m Cell,Element:2*n(i) Matrix,each column is the start and end Symbol position of Box  

m = size(WordBounds,2);

for i = 1:m
    BoxSymbolMap{i} = WordSymbolMapThisLine(SymbolBounds{i},WordBounds{i});
end