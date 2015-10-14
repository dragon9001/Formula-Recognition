function EmbeddedFormulaShow()
%% Draw the 3-D distribute of formulus using 3-D Feature
% Density, Relativeheight, and Fluctuation
%
Files = dir('*.mat');

PixelDensity = [];
Relativeheight = [];
Symbolfluctuation = [];
Label1 = [];
WordFeature = [];
for i = 1: size(Files,1);
    load(Files(i).name);
    
    for j = 1 : size(WordFeature,2)
        for k = 1: size(WordFeature{j},2)
            PixelDensity = [PixelDensity;WordFeature{j}(k).PixelDensity];
            Relativeheight = [Relativeheight;WordFeature{j}(k).Relativeheight];
            Symbolfluctuation = [Symbolfluctuation;WordFeature{j}(k).Symbolfluctuation];
            Label1 = [Label1;WordFeature{j}(k).Label];           
        end
    end
end
Feature1 = [PixelDensity Relativeheight Symbolfluctuation];

idx = randperm(size(Feature1,1));
Feature = Feature1(idx,:);
Label = Label1(idx,:);

m = floor(0.8*size(Feature,1));

TrainX = Feature(1:m,:);
TrainY = Label(1:m,:);
TestX = Feature(m+1:end,:);
TestY = Label(m+1:end,:);

model = libsvmtrain(TrainY,TrainX);
[predicted_label, accuracy, decision_values] = libsvmpredict(TestY, TestX,model);

figure;


end