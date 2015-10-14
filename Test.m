imgrgb = imread('Textline Segment.jpg');
imgGray = rgb2gray(imgrgb);

SE = strel('rectangle', [8,2]);
imgDialte = imopen(imgGray,SE);


BinaryImg = imgDialte;
BinaryImg(BinaryImg<=126) = 0;
BinaryImg(BinaryImg>126) = 1;
BinaryImg = logical(BinaryImg);

BinaryImg = ~BinaryImg;

imshow(BinaryImg);
A = WordSegmentation(BinaryImg);