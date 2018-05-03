clear;
clc;
close all;

fabric = 'C:\Users\Jonas\Documents\PSU\CMPEN 497\Final Project\image\fabric';
foliage = 'C:\Users\Jonas\Documents\PSU\CMPEN 497\Final Project\image\foliage';
glass = 'C:\Users\Jonas\Documents\PSU\CMPEN 497\Final Project\image\glass';
leather = 'C:\Users\Jonas\Documents\PSU\CMPEN 497\Final Project\image\leather';
metal = 'C:\Users\Jonas\Documents\PSU\CMPEN 497\Final Project\image\metal';
paper = 'C:\Users\Jonas\Documents\PSU\CMPEN 497\Final Project\image\paper';
plastic = 'C:\Users\Jonas\Documents\PSU\CMPEN 497\Final Project\image\plastic';
stone = 'C:\Users\Jonas\Documents\PSU\CMPEN 497\Final Project\image\stone';
water = 'C:\Users\Jonas\Documents\PSU\CMPEN 497\Final Project\image\water';
wood = 'C:\Users\Jonas\Documents\PSU\CMPEN 497\Final Project\image\wood';

disp('Im Load');
allImages = [];
singleWavelet = [];

for i=1:10
    if (i==1) myFolder = fabric;
    elseif (i==2) myFolder = foliage;
    elseif (i==3) myFolder = glass;
    elseif (i==4) myFolder = leather;
    elseif (i==5) myFolder = metal;
    elseif (i==6) myFolder = paper;
    elseif (i==7) myFolder = plastic;
    elseif (i==8) myFolder = stone;
    elseif (i==9) myFolder = water;
    elseif (i==10) myFolder = wood;
    end

    filePattern = fullfile(myFolder, '*.jpg');
    jpegFiles = dir(filePattern);
    for k = 1:length(jpegFiles)baseFileName = jpegFiles(k).name;
        fullFileName = fullfile(myFolder, baseFileName);
        fprintf(1, 'Now reading %s\n', myFolder);

        imageArray = imread(fullFileName);
        if (size(imageArray,3)== 3)
          imageArray = rgb2gray(imageArray);
        end
        imageArray = imresize(imageArray,[160 120]);

%         [len,width] = size(imageArray);
%         newImage = reshape(imageArray, [1, (len*width)]);
        
        level = 3;
        wavelet = 'bior1.1';
        
        [c,s]=wavedec2(imageArray,level,wavelet); 
        [H3,V3,D3] = detcoef2('all',c,s,level);
        A3 = appcoef2(c,s,wavelet,level);
        
        A3img = wcodemat(A3,255,'mat',1);
        H3img = wcodemat(H3,255,'mat',1);
        V3img = wcodemat(V3,255,'mat',1);
        D3img = wcodemat(D3,255,'mat',1);
        
        [len,width] = size(A3img);
        AnewImage = reshape(A3img, [1, (len*width)]);
        HnewImage = reshape(H3img, [1, (len*width)]);
        VnewImage = reshape(V3img, [1, (len*width)]);
        DnewImage = reshape(D3img, [1, (len*width)]);
        
%         figure;
%         subplot(2,2,1);
%         imagesc(A3img);
%         colormap pink(255);
%         title('Approximation Coef. of Level 3');
%         subplot(2,2,2)
%         imagesc(H3img);
%         title('Horizontal detail Coef. of Level 3');
%         subplot(2,2,3)
%         imagesc(V3img);
%         title('Vertical detail Coef. of Level 3');
%         subplot(2,2,4)
%         imagesc(D3img);
%         title('Diagonal detail Coef. of Level 3');
        
        % Four 54x44 wavelet images
        allImages = [allImages; i, AnewImage, HnewImage, VnewImage, DnewImage];
        
%         singleWavelet = [singleWavelet; i, AnewImage];
        
    end
end

disp('Write CSV');
csvwrite('AllWavelets.csv',allImages);
% csvwrite('SingleWavelets.csv',singleWavelet);

%%
% Seperate full wavelet dataset into train and test CSVs

data = allImages;
% data = singleWavelet;

[row,col] = size(data);

TrainWavelet = [];
TestWavelet = [];


disp('Seperate wavelets');
index=1;

for i=1:row
    
    % Test CSV
    if(index>90)
        TestWavelet = [TestWavelet; data(i,:)];

    %  Train CSV
    else
        TrainWavelet = [TrainWavelet; data(i,:)];
    end
    
    % 100 images in each category
    if (index == 100)
        index = 1;
    else
        index = index + 1;
    end
    
end

disp('Write CSV');
csvwrite('TrainWavelet.csv',TrainWavelet);
csvwrite('TestWavelet.csv',TestWavelet);

disp('Done');
