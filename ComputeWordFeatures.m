function WordFeature = ComputeWordFeatures(hfig)
%% Compute WordFeatures

Handles = hfig.UserData.AllHandles;
n = size(Handles,2);
imgGray = hfig.UserData.imgGray;
SymbolBounds = hfig.UserData.SymbolBounds;

imgBinary = imgGray;    imgHeight = size(imgGray,1);
imgBinary(imgBinary<=127) = 0;
imgBinary(imgBinary>127) = 1;

WordBounds = cell(n,1);
for i = 1:n
    WordBounds{i} = GetBoundsByBoxHandle(hfig.UserData.AllHandles{i});
end

WordFeature = cell(1,n);
for i = 1:n
    LineLength = size(WordBounds{i},2);
    for j = 1:LineLength
        ThisWordBound = WordBounds{i}(:,j);
%         WordFeature{i}(j).WordBound = ThisWordBound;
        WordFeature{i}(j).WordImg = imgGray(ThisWordBound(2):ThisWordBound(1),ThisWordBound(3):ThisWordBound(4));
        
        %Density Feature
        WordBinaryImg = imgBinary(ThisWordBound(2):ThisWordBound(1),ThisWordBound(3):ThisWordBound(4));
        WordFeature{i}(j).PixelDensity = sum(sum(1 - WordBinaryImg))...
            /((ThisWordBound(1)-ThisWordBound(2)+1)*(ThisWordBound(4)-ThisWordBound(3)+1));
        
        %Height Feature
        WordFeature{i}(j).Relativeheight = (ThisWordBound(1)-ThisWordBound(2))/imgHeight;
        
        % Compute Fluctuation for this line.    
        
        SymbolBoundThisWord = findSymbolBoundThisWord(SymbolBounds{i},ThisWordBound);
        
        p = size(SymbolBoundThisWord,2);
        SymbolCentroid = zeros(2,p);        
        for k = 1 : p
            SymbolCentroid(:,k) = [(SymbolBoundThisWord(1,k)+SymbolBoundThisWord(2,k))/2;(SymbolBoundThisWord(3,k)+SymbolBoundThisWord(4,k))/2];
        end
        Symbolvi = zeros(2,p-1);
        Symbolfluctuation = 0;
        for k = 1 : p - 1
            Symbolvi(:,k) = SymbolCentroid(:,k+1)-SymbolCentroid(:,k);
            Symbolfluctuation = Symbolfluctuation + abs( acos(dot(Symbolvi(:,k),[1 0]')/norm(Symbolvi(:,k))) );
        end
        WordFeature{i}(j).Symbolfluctuation = Symbolfluctuation;
        
                %% Label the data
        if sum(Handles{i}(j).EdgeColor == [0 0.7 0.7]) == 3
            WordFeature{i}(j).Label = true;
        else
            WordFeature{i}(j).Label = false;
        end
    end
end

end