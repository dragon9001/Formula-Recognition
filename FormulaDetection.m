function FormulaDetection(ppPath)
%%
%Formula Detection Method.
imgrgb = imread(ppPath);
imgGray = rgb2gray(imgrgb);

% imgGray = imgGray(:,400:2100);
imgGray = imgGray(301:2000,181:1500);

%% Produce BinaryImg
BinaryImg = imgGray;
BinaryImg(BinaryImg<=126) = 0;
BinaryImg(BinaryImg>126) = 1;
BinaryImg = logical(BinaryImg);
BinaryImg = ~BinaryImg;

%% TextLineSegment

blksize = 2;

[LinesPos,homogenizationImg] = TextLineSeg(imgGray,blksize);

BinaryHomogenizationImg = homogenizationImg;
BinaryHomogenizationImg(BinaryHomogenizationImg>0) = 1; % BinaryImage could also use imshow() to show it.

%SymbolBounds and WordBounds uses Cell Structure.Each line Bounds
%Infomation were stored in the same Cell. Cell has a lenth m,which is equal
%to Line Number.
[SymbolBounds,WordBounds] = WordSegment(imgGray,LinesPos);

% [BoxHandles,BoxSymbolMap] = WordSymbolMap(SymbolBounds,WordBounds);
% 
imshow(imgGray);
[BoxHandles] = DrawBoxAndGetBoxHandles(WordBounds);

hfig = BoxHandles{1}(1).Parent.Parent;
hfig.UserData.imgGray = imgGray;
hfig.UserData.LinesPos = LinesPos;
hfig.UserData.SymbolBounds = SymbolBounds;
% [BoxSymbolMap] = WordSymbolMap(SymbolBounds,WordBounds); %合并以后再算

CombineBoxes(BoxHandles);

pause;

close all;