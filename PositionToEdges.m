function EdgesArray = PositionToEdges(PositionArray)

m = size(PositionArray,2);
EdgesArray = zeros(4,m);

for i = 1:m
    if(PositionArray(3,i) < 0 || PositionArray(4,i) < 0)
        error('Error in PositionToEdges()');
    end

    EdgesArray(2,i) = PositionArray(2,i);
    EdgesArray(1,i) = PositionArray(2,i) + PositionArray(4,i);
    EdgesArray(3,i) = PositionArray(1,i);
    EdgesArray(4,i) = PositionArray(1,i) + PositionArray(3,i);
end

end