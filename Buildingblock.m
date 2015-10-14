function blkimg =  Buildingblock(img,blksize)
%%This function seperate imgs to k*k blocks.
%the blocks would be stored in an 4-D Matrix
%where the last two dimension are block coordinates
%and the first two dimension is a k*k pixel block
%EX1:
% blkimg(1,2,:,:) returns a k*k matrix;
% 

blockrows = floor(size(img,1)/blksize);
blockcols = floor(size(img,2)/blksize);

blkimg = zeros(blksize,blksize,blockrows,blockcols);

for i = 1:blockrows
    for j = 1:blockcols
        blkimg(:,:,i,j) = img(blksize*(i-1)+1:blksize*i,blksize*(j-1)+1:blksize*j);       
    end
end

end