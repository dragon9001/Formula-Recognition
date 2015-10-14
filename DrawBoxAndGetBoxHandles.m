function [BoxHandles] = DrawBoxAndGetBoxHandles(WordBounds)
%% This function 
% input WordBounds and SymbolBounds of All Line
% output:
% BoxHandles --- a 1*m Cell,Element contains n(i) Box handles of this text line

m = size(WordBounds,2);

for i = 1:m
    BoxHandles{i} = ShowBounds(WordBounds{i});
end


end 
