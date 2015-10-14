function  LineFeature = ComputeTextLineFeatures(hfig)
%% Compute the Features for this Image.
%
%
Handles = hfig.UserData.AllHandles;
n = size(Handles,2);
LinesPos = hfig.UserData.LinesPos;
imgGray = hfig.UserData.imgGray;
Handles = hfig.UserData.AllHandles;

imgBinary = imgGray;    imgHeight = size(imgGray,1); imgWidth = size(imgGray,2);
imgBinary(imgBinary<=127) = 0;
imgBinary(imgBinary>127) = 1;

LineFeature = cell(1,n);
WordBounds_save = cell(1,n);

for i = 1:n
    WordBounds_save{i} = GetBoundsByBoxHandle(Handles{i});  %GetBoundsByBoxHandle Works only for lines.
end

for i = 1:n
    %% Compute Image of this line
    LineFeature{i}.LineImg = imgGray(LinesPos(1,i):LinesPos(2,i),1:imgWidth);
    
    
    LineFeature{i}.PixelDensity = sum(sum( 1- imgBinary(LinesPos(1,i):LinesPos(2,i),:) )) ...
        /(imgWidth*(LinesPos(2,i)-LinesPos(1,i)+1));
    LineFeature{i}.Relativeheight = (LinesPos(2,i) - LinesPos(1,i))/imgHeight;
    LineFeature{i}.fl = WordBounds_save{i}(3,1);
    LineFeature{i}.fr = imgWidth - WordBounds_save{i}(4,end);
    
    %% compute m Centroid then get m-1 arccosdot(vi,vh) where vh = [1 0]';
    %then sum them up. to be fluctation
    m = size(WordBounds_save{i},2);
    Centroid = zeros(2,m);
    for j = 1:m
        Centroid(:,j) = [(WordBounds_save{i}(1,j)+WordBounds_save{i}(2,j))/2;(WordBounds_save{i}(3,j)+WordBounds_save{i}(4,j))/2];
    end
    vi = zeros(2,m-1);
    fluctuation = 0;
    for j = 1:m-1
        vi(:,j) = Centroid(:,j+1)-Centroid(:,j);
        fluctuation = fluctuation + abs(acos(dot(vi(:,j),[1 0]')/norm(vi(:,j))));
    end
    LineFeature{i}.fluctuation = fluctuation;
    
    %% Label the data
    if m == 1 && sum(Handles{i}(1).EdgeColor == [0 0.7 0.7]) == 3
        LineFeature{i}.Label = true;
    else
        LineFeature{i}.Label = false;
    end
end
end