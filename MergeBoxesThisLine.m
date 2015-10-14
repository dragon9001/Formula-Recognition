function [newHandle] = MergeBoxesThisLine(Handles)
% input: 1*m handles and 1*m WordBounds of This Line
% output: 1 new handles
% 1.n WordsBoxes -> 1 Boxes (and also merge n to 1,then store it in NewWordBounds)
% 2.n handles -> 1 handle (then delete)
% 3.

WordBounds = GetBoundsByBoxHandle(Handles);

m = size(Handles,2);
if size(Handles,2) ~= size(WordBounds,2) || size(Handles,1) ~= 1 || size(WordBounds,1) ~= 4 
    error('error in MergeBoxes()');
end

newWordBounds = [max(WordBounds(1,:));min(WordBounds(2,:));WordBounds(3,1);WordBounds(4,m)];
newHandle = ShowBounds(newWordBounds);

newHandle.UserData.Position  = Handles(1).UserData.Position;

end