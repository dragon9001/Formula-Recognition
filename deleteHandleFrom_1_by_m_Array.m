function hArray = deleteHandleFrom_1_by_m_Array(hArray,hObject)
%% delete hObject from a

idx = 0;
m = size(hArray,2);
for i = 1:m
    if sum(hArray(i).Position == hObject.Position) == 4
        idx = i;
    end
end
if idx == m && hArray(i) ~= hObject
    error('delete non-exist hObject in ClickCallBack()');
end
%delete the Box handle
hArray = [hArray(:,1:idx-1) hArray(:,idx+1:m)];