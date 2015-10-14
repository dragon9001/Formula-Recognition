function PositionArray = EdgesToPosition(EdgesArray)

m = size(EdgesArray,2);
PositionArray = zeros(4,m);

for i = 1:Position
    if(EdgesArray(1,i) > EdgesArray(2,i) || EdgesArray(3,i) > EdgesArray(4,i))
        error('Error in EdgesToPosition()');
    end
    PositionArray(1,i) = EdgesArray(3,i);
    PositionArray(2,i) = EdgesArray(2,i);
    PositionArray(3,i) = EdgesArray(4,i) - EdgesArray(3,i);
    PositionArray(4,i) = EdgesArray(1,i) - EdgesArray(2,i);
end

end