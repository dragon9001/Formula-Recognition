function LinesPos = FindLines(TextPixelRows)

idx = 1;
pstart = 0;
pend = 0;
LinesPos = [];

for i = 2:length(TextPixelRows)-1
    if (TextPixelRows(i-1) == 0)&(TextPixelRows(i+1) == 1)
        pstart = i;
    end
    if (TextPixelRows(i) == 1)&(TextPixelRows(i+1) == 0)
        pend = i;
        LinesPos = [LinesPos [pstart;pend]];
        idx = idx + 1;
    end
    
end

if(TextPixelRows(1) == 1) & (LinesPos(1,1) ==2)
    LinesPos(1,1) = 1;
end

if(TextPixelRows(length(TextPixelRows)) == 1) & (LinesPos(length(TextPixelRows)-1,2) == TextPixelRows-1)
    LinesPos(1,1) = 1;
end

end