function demo()

close all;

hfig = figure('Position',[200 100 1000 750]);
h_edit_Predict=uicontrol('style','edit','backgroundcolor',[1 1 1],'position',[20 250 100 50],...
   'tag','myedit','string','预测','horizontalalignment','left');

h_edit_Label=uicontrol('style','edit','backgroundcolor',[1 1 1],'position',[170 250 100 50],...
   'tag','myedit','string','实际','horizontalalignment','left');

h_edit_Accuracy=uicontrol('style','edit','backgroundcolor',[1 1 1],'position',[320 250 100 50],...
   'tag','myedit','string','正确率','horizontalalignment','left');


haxe2 = axes('Parent',hfig,'Position',[0.025 0.94 0.13 0.04],'XTick',[],'YTick',[],'Box','On');

haxe = axes('Parent',hfig,'Position',[0.025 0.425 0.95 0.5],'XTick',[],'YTick',[],'Box','On');

h_pausebut1=uicontrol('parent',hfig,'style','pushbutton','position',[50 50 250 50],...
    'string','暂停','FontSize',18,'callback',@CallBackBtn1);
h_pausebut2=uicontrol('parent',hfig,'style','pushbutton','position',[350 50 250 50],...
    'string','继续','FontSize',18,'callback',@CallBackBtn2);

load([pwd '/model/' 'model.mat']);

htext = text('Parent',haxe2,'Position',[0.02 0.5],'String','Classify Picutre','FontSize',18);

Files = dir('*.mat');
Feature1UnNorm = [];
Label1 = [];

%%首先取出TestingData
for i = 1: 2%size(Files,1);
    load(Files(9+i).name);
    
    for j = 1 : size(WordFeature,2)
        for k = 1: size(WordFeature{j},2)
            img = WordFeature{j}(k).WordImg;
            imgR = imresize(img,[256 256]);

            PixelFeature = imgR(:)';
            Feature1UnNorm = [Feature1UnNorm ;PixelFeature];   
            Label1 = [Label1;WordFeature{j}(k).Label];  
        end
    end
end

idx = 1; %一开始输出第一个Word的预测结果
numerator = 0;
denominator = 0;

Feature1UnNorm = double(Feature1UnNorm);
[Feature1, mu, sigma] = featureNormalize(Feature1UnNorm);
[predicted_label, accuracy, decision_values] = libsvmpredict(Label1, Feature1,model);

a = 0;

for i = 1: 2%(Files,1);
    load(Files(9+i).name);
    
    for j = 1 : size(WordFeature,2)
        for k = 1: size(WordFeature{j},2)
            if Label1(idx) == 1
                img = WordFeature{j}(k).WordImg;
                himg{i}{j}(k) = imshow(img);
                
                
                if Label1(idx) == 0
                    set(h_edit_Label,'String',['实际值:' '字符']);
                else
                    set(h_edit_Label,'String',['实际值:' '公式']);
                end
                
                if predicted_label(idx) == 0
                    set(h_edit_Predict,'String',['预测值:' '字符']);
                else
                    set(h_edit_Predict,'String',['预测值:' '公式']);
                end
                if Label1(idx) == predicted_label(idx)
                    numerator = numerator + 1;
                end
                
                denominator = denominator + 1;
                set(h_edit_Accuracy,'String',['准确率:' num2str(numerator/(denominator))]);
                pause(1.5);
                delete(himg{i}{j}(k));
            end
            idx = idx + 1;
            if idx == size(Label1,1);
                close all;
            end
        end
    end
end

end

function CallBackBtn1(hObject, evt)

w = waitforbuttonpress;

end
function CallBackBtn2(hObject, evt)

end