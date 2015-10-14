function Bounds = FindBoundsUsingDialatedConnectivity(TextLineBinaryImgs)

ConnectivityMap = bwlabel(TextLineBinaryImgs);

SymbolNum = max(max(ConnectivityMap));

Bounds = zeros(4,SymbolNum); % Each Dimension representing Upper, Lower, Left and Right Bound.

%% Build the Bounds
for i = 1 : SymbolNum
    [r,c] = find(ConnectivityMap == i);
    Bounds(1,i) = max(r);
    Bounds(2,i) = min(r);
    Bounds(3,i) = min(c);
    Bounds(4,i) = max(c);
end