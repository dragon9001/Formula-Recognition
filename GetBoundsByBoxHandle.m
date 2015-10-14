function WordBounds = GetBoundsByBoxHandle(Handles)
%% GetBounds of This Line by Handles
% input: 1*m Handles
% ontput: 4*m WordBounds

m = size(Handles,2);

Position = zeros(4,m);
for i = 1 : m
    Position(:,i) = Handles(i).Position';
end

WordBounds = PositionToEdges(Position);

end

