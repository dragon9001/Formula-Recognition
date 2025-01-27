function [SymbolBounds,WordBounds] = WordSegment(imgGray,LinesPos)
%% Compute WordBox and SymbolBox for img.
% WordBox is based on SymbolBox combination in each Img line.
% Steps: 
% 1.Conectivity Detection to Decide SymbolBox(For Seperated Symbol Parts,Use Dialate)
% 2.
%% Conectivity Detection
SE = strel('rectangle', [8,2]);
imgDialte = imopen(imgGray,SE);

BinaryImg = imgDialte;
BinaryImg(BinaryImg<=126) = 0;
BinaryImg(BinaryImg>126) = 1;
BinaryImg = logical(BinaryImg);
BinaryImg = ~BinaryImg;

%% 
SymbolBounds = {};
WordBounds = {};
% imshow(imgGray);
%% Find Symbol bounds and Word bounds for every line.
NearbyThreshold = 9; %This Threshold is a little bigger than the distance between two symbols in the same word.
for i = 1:size(LinesPos,2);
    TextLineBinaryImgs = BinaryImg(LinesPos(1,i):LinesPos(2,i),:);
    SymbolBoundsThisLineRelativePos = FindBoundsUsingDialatedConnectivity(TextLineBinaryImgs); %Found all symbol Bounds of this Img.Bounds:4*m Matrix.
    SymbolBounds{i} = [SymbolBoundsThisLineRelativePos(1:2,:) + LinesPos(1,i) - 1;SymbolBoundsThisLineRelativePos(3:4,:)];
    WordBoundsThisLineRelativePos = WordSegmentationThisLine(SymbolBoundsThisLineRelativePos,NearbyThreshold,TextLineBinaryImgs); %TextLineBinaryImgs is for Debugging.
    WordBoundsThisLineAbsolutePos = [WordBoundsThisLineRelativePos(1:2,:) + LinesPos(1,i) - 1;WordBoundsThisLineRelativePos(3:4,:)];
    WordBounds{i} = WordBoundsThisLineAbsolutePos;
end

hold on ;