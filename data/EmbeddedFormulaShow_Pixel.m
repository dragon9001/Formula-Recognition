function EmbeddedFormulaShow_Pixel()
%% Draw the 3-D distribute of formulus using 3-D Feature
% Density, Relativeheight, and Fluctuation
%
Files = dir('*.mat');
Feature1UnNorm = [];
Label1 = [];
for i = 1: size(Files,1);
    load(Files(i).name);
    
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
Feature1UnNorm = double(Feature1UnNorm);
[Feature1, mu, sigma] = featureNormalize(Feature1UnNorm);
PositieLabelNum = sum(Label1 == 1);
FeatureZeroLabel = Feature1(Label1 == 0,:);

idx = randperm(size(FeatureZeroLabel,1));
idx = idx(1:PositieLabelNum);
% 随机抽与正样本数量相同的负样本
Feature2 = [FeatureZeroLabel(idx,:);Feature1(Label1==1,:)];
Label2 = [zeros(PositieLabelNum,1);ones(PositieLabelNum,1)];

idx = randperm(size(Label2,1));
Feature = Feature2(idx,:);
Label = Label2(idx,:);

m = floor(0.8*size(Feature,1));

TrainX = Feature(1:m,:);
% TrainX = double(TrainX);
TrainY = Label(1:m,:);
TestX = Feature(m+1:end,:);
% TestX = double(TestX);
TestY = Label(m+1:end,:);

model = libsvmtrain(TrainY,TrainX);
[predicted_label, accuracy, decision_values] = libsvmpredict(TestY, TestX,model);


end