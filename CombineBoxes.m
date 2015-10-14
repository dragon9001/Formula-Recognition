function CombineBoxes(BoxHandles)
%% ConmbineBoxes Manually Line by Line 
% PreWork:
% 1.Set Box Handles to be clickable
% 2.Set the ClickCallBack:

LinesNum = size(BoxHandles,2);
hMergeButton = uicontrol('parent',BoxHandles{1}(1).Parent.Parent,'style','pushbutton','position',[10 10 120 20],'string','Merge and Label',...
   'callback',@BtnCallBack);
hSaveButton = uicontrol('parent',BoxHandles{1}(1).Parent.Parent,'style','pushbutton','position',[140 10 120 20],'string','Feature and Save',...
   'callback',@ComputerFeatureandSaveCallBack);

Hfig = hMergeButton.Parent;
Hfig.UserData.AllHandles = BoxHandles;
Hfig.UserData.MergeList = [];

% Set Box Handles to be clickable
for i = 1:LinesNum
    m = size(BoxHandles{i},2);
    for j = 1:m 
        BoxHandles{i}(j).PickableParts = 'all';
        set(BoxHandles{i}(j),'ButtonDownFcn',@ClickCallBack);
        BoxHandles{i}(j).UserData.Position = [i;j];
    end
end

end
%% BoxClickCallBack: 
% 1.Move(copy and then delete) this Box to a new List.(when Click Again undo it);
% 2.Change the color of this box.
function ClickCallBack(hObject, evt)

    if sum(hObject.EdgeColor == [0 1 0]) == 3 || sum(hObject.EdgeColor == [0 0.7 0.7]) == 3
        hObject.EdgeColor = [0 0 1];
%         AddObjectToMergeList(hObject);
        a = hObject.Parent.Parent.UserData.MergeList;
        a = [a hObject];
        a = SortByPosition(a); %按位置Position(1)排序保证a中靠左的元素在前.
        hObject.Parent.Parent.UserData.MergeList = a;
    elseif sum(hObject.EdgeColor == [0 0 1 ]) == 3
        hObject.EdgeColor = [0 1 0];
        %RemoveObjectToMergeList(hObject);
        a = hObject.Parent.Parent.UserData.MergeList;
        
        %locate and delete Box handle.
        a = deleteHandleFrom_1_by_m_Array(a,hObject);

        hObject.Parent.Parent.UserData.MergeList = a;
    else
        disp('color error in ClickCallBack()');
        return;
    end
end

%% Btn CallBack 
% 1.Conpute new Box Edge of the List
% 2.delete the old Box Handle
% 3.Draw new Box,and put it's handle in a proper postion.

% EdgesArray = PositionToEdges(PositionArray)
% PositionArray = EdgesToPosition(EdgesArray)
% FeatureExtraction()
function BtnCallBack(hObject, evt)
    HandlesToMerge = hObject.Parent.UserData.MergeList;
    if isempty(HandlesToMerge)
        return;
    end
    
    m = size(HandlesToMerge,2);
    Positions = zeros(4,m);
    for i = 1:m
        Positions(:,i) = HandlesToMerge(i).Position';
    end
    
    [NewHandle] = MergeBoxesThisLine(HandlesToMerge);
    %Set New Box to Labeled State;
    NewHandle.EdgeColor = [0 0.7 0.7];
    NewHandle.LineWidth = 2;
    NewHandle.PickableParts = 'all';
    set(NewHandle,'ButtonDownFcn',@ClickCallBack);
    
    %RemoveMergedHandlesFromNewHandle;
    
    %delete the handle Object from GUI 
    HandlesToDelete = HandlesToMerge;
    m = size(HandlesToMerge,2);
    
    %Reconstuct Handles.
    LineID = NewHandle.UserData.Position(1);
    hArray = hObject.Parent.UserData.AllHandles{LineID};
    for i = 1:m
        hElemToDelete = HandlesToMerge(i);
        hArray = deleteHandleFrom_1_by_m_Array(hArray,hElemToDelete);        
        delete(HandlesToDelete(i));
    end
    
    % hObject.Parent.UserData.NewHandle{LineID} = SortByPosition([NewHandle hArray]);
    hObject.Parent.UserData.AllHandles{LineID} = SortByPosition([NewHandle hArray]);
    
    hObject.Parent.UserData.MergeList = [];
end

%% SaveBtn CallBack 
% 1.Conpute All WordBounds and SymbolBounds of Each Line.
% 2.LineFeature and WordFeture Compute.
% 3.Compute Labels of All Box.
% 4.Save img,LinePos,LineFeature,WordBounds,WordFeature,SymbolBounds.Labels
% All Datas Was store in 1*n Cells,Each Cell represnt a TextLine.
%
function ComputerFeatureandSaveCallBack(hObject, evt)
    hfig = hObject.Parent;

    %% Compute Text Line Features
    %  LineFeature = cell(n,1);
    LineFeature = ComputeTextLineFeatures(hfig);
    

    %% Compute Word Features.
    %  WordFeature = cell(n,1);    
    WordFeature = ComputeWordFeatures(hfig);
    
    %% SaveData
    Time = clock;
    Timestr = [num2str(Time(3)) '-' num2str(Time(4)) '-' num2str(Time(5)) '-' num2str(Time(6)) '-'];
    SavePath = [pwd '/' 'data' '/' Timestr '.mat'];
    save(SavePath,'LineFeature','WordFeature');
end

