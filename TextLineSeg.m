function [LinesPos,homogenizationImg] = TextLineSeg(img,blksize)

blocksize = blksize;
blockrows = floor(size(img,1)/blocksize);
blockcols = floor(size(img,2)/blocksize);

%%
%reshape image to exactly divide blocksize
img = img(1:blockrows*blocksize,1:blockcols*blocksize);

%%
%Compute w(1) to w(m) where w(i) is a matrix of block size
w1 = [ones(blocksize/2,blocksize/2) -ones(blocksize/2,blocksize/2);-ones(blocksize/2,blocksize/2) ones(blocksize/2,blocksize/2)];
w2 = [-ones(blocksize/2,blocksize);ones(blocksize/2,blocksize)];
w3 = [ones(blocksize,blocksize/2) -ones(blocksize,blocksize/2)];

%%
%Compute if a block is homogeneous for every block
homogeneousJudgeMatrix = zeros(blockrows,blockcols); %��ʼ��Ϊͬ�ʾ���ɨ��һ������ʵ��޸�Ϊ1
homogeneousMatrix = zeros(blockrows,blockcols);
blkimg = Buildingblock(img,blocksize);
TempBlock = zeros(blocksize,blocksize);

deltanorm = 0;
HomoThreshold = 30;

for i = 1:blockrows
    for j = 1:blockcols
        TempBlock = blkimg(:,:,i,j);
        delta1 = abs(dot(w1(:),TempBlock(:))); 
        delta2 = abs(dot(w2(:),TempBlock(:))); 
        delta3 = abs(dot(w3(:),TempBlock(:))); 
        deltanorm = norm([delta1;delta2;delta3],1);
        if(deltanorm >0)
            disp('');
        end
        if (deltanorm >= HomoThreshold)
            homogeneousJudgeMatrix(i,j) = 1;   %��ס���ʵ���1
        end
    end
end

homogeneousMatrix = homogeneousJudge(homogeneousJudgeMatrix);

homogenizationImg = kron(homogeneousMatrix,255*ones(blocksize,blocksize));

% imshow(homogenizationImg);

%%��ʾһ��������ͬ�ʾ�����Ȼ�������á�

SortedhomogenizationImg = sort(homogenizationImg,2,'descend');
% imshow(SortedhomogenizationImg);

%% �������ı����ж���10% Threshold
ProjectY = sum(homogenizationImg');
LineTreshold = 0.03*mean(ProjectY);

%% Find out Text Lines,Stored in LinesPos as an 2*m Matrix.
% Each Vector consists of the start-pixel and end-pixel along vertical axis.
TextPixelRows = (ProjectY>LineTreshold);
LinesPos = FindLines(TextPixelRows);

%% put the text lines in shadow(pixel intensity of 128)
for i = 1: size(LinesPos,2)
    img(LinesPos(1,i):LinesPos(2,i),:) = img(LinesPos(1,i):LinesPos(2,i),:) - 128;
end

imshow(img);

