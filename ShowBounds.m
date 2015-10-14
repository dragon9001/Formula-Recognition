function handles = ShowBounds(WordBoundsThisLine)

% imshow(img);
hold on;
handles = handle(1);

for i = 1 : size(WordBoundsThisLine,2);
%     LeftBound = Bounds(3,i);
%     LowerBound = Bounds(2,i);
%     Width = Bounds(4,i) - Bounds(3,i);
%     Height = Bounds(1,i) - Bounds(2,i);
    BoxRect = [WordBoundsThisLine(3,i) WordBoundsThisLine(2,i) WordBoundsThisLine(4,i) - WordBoundsThisLine(3,i) WordBoundsThisLine(1,i) - WordBoundsThisLine(2,i)];
    handles(i) = rectangle('Position',BoxRect,'LineWidth',1,'LineStyle','-','EdgeColor','g');
    hold on;
end

