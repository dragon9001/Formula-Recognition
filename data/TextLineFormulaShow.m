function TextLineFormulaShow()
%% Draw the 3-D distribute of formulus using 3-D Feature
% Density, Relativeheight, and Fluctuation
%
Files = dir('*.mat');

PixelDensity = []; fl =[]; fr=[];
Relativeheight = [];
Symbolfluctuation = [];
Label1 = [];
LineFeature = [];

for i = 1: size(Files,1);
    load(Files(i).name);
    for j = 1 : size(LineFeature,2)
            PixelDensity = [PixelDensity;LineFeature{j}.PixelDensity];
            Relativeheight = [Relativeheight;LineFeature{j}.Relativeheight];
            Symbolfluctuation = [Symbolfluctuation;LineFeature{j}.fluctuation];
            fl = [fl;LineFeature{j}.fl];
            fr = [fr;LineFeature{j}.fr];
            Label1 = [Label1;LineFeature{j}.Label];           
    end
end
Feature1 = [PixelDensity Relativeheight Symbolfluctuation fl fr];

idx = randperm(size(Feature1,1));
FeatureUnNorm = Feature1(idx,:);
[Feature, mu, sigma] = featureNormalize(FeatureUnNorm);

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