function WordBounds = WordSegmentationThisLine(SymbolBounds,NearbyThreshold,TextLineBinaryImgs)
%% This InputBounds Refer to Symbol Bounds, and it would Tend to be

Bounds = SymbolBounds; %%Reduct Bounds to WordBounds step by step
SymbolNum = size(Bounds,2);

%%    mergeBox(Bounds(i),Bounds(i+1))

% 水平的扫描一遍
i = 1;
while i < SymbolNum
    while(i < SymbolNum)&(Bounds(3,i+1) - Bounds(4,i) < NearbyThreshold )%左右邻接关系，左在前 
        Bounds(:,i)=[max([Bounds(1,i) Bounds(1,i+1)]);min([Bounds(2,i) Bounds(2,i+1)]);Bounds(3,i);Bounds(4,i+1)];
        Bounds = Bounds(:,[1:i i+2:SymbolNum]);
        SymbolNum = SymbolNum - 1;
    end
    i = i + 1;
end
% ShowBounds(Bounds);
WordBounds = Bounds;

%% Combine the Words that Words{i-1} contain a symbol and Words{i+1} also contains a symbol
%
%IsSymbol的输入为两个矩阵，输出为true或false
j = 2;
BoxID_tobecombined = []; %这是待合并的SymbolWord的编号集
%对第一个Word做特殊处理
if size(WordBounds,2) > 2
    if IsSymbol(WordBounds(:,2),SymbolBounds) & IsSymbol(WordBounds(:,3),SymbolBounds);
        BoxID_tobecombined = [1 2 3];
    end
end
% 再对其他的Word做一般处理
while j <= size(WordBounds,2) - 1;
    if IsSymbol(WordBounds(:,j-1),SymbolBounds) & IsSymbol(WordBounds(:,j+1),SymbolBounds)
        BoxID_tobecombined = [BoxID_tobecombined j-1 j j+1];
%         Temp = [max([WordBounds(1,j-1) WordBounds(1,j) WordBounds(1,j+1)]);min([WordBounds(2,j-1) WordBounds(2,j) WordBounds(2,j+1)]);WordBounds(3,j-1);WordBounds(4,j+1)];
%         WordBounds = [WordBounds(:,1:j-2) Temp WordBounds(:,j+2:size(WordBounds,2))];
    end
    j = j+1;
end
BoxID_tobecombined = sort(BoxID_tobecombined);
BoxID_tobecombined = unique(BoxID_tobecombined);

if ~isempty(BoxID_tobecombined);
    BoxStartandEndPos = FindHeadAndTailForContinuousInteger(BoxID_tobecombined); %这是化简为<Start1,End1>;<start2,end2> ...编号集合。第一行是开始，第二行是结束
%赋初值，每切完一个Box后更新。
    p_start = BoxStartandEndPos(1,1);
    p_end = BoxStartandEndPos(2,1);
    for i = 1:size(BoxStartandEndPos,2)
        Temp = [max(WordBounds(1,p_start:p_end));min(WordBounds(2,p_start:p_end));WordBounds(3,p_start);WordBounds(4,p_end)];
        WordBounds = [WordBounds(:,1:p_start-1) Temp WordBounds(:,p_end+1:size(WordBounds,2))];
        if i < size(BoxStartandEndPos,2)
            diffrence(i) = p_end - p_start;
            p_start = BoxStartandEndPos(1,i+1) - sum(diffrence(1:i));
            p_end = BoxStartandEndPos(2,i+1) - sum(diffrence(1:i));
        end
    end
end

end