clear;
clc;
close all;

fabric = '\\Psbdfilesrvr.psu-erie.bd.psu.edu\student\KRJ5137\Private\Documents\PSU\Spring 2018\CMPEN 497\Final Project\FMD\image\fabric';
foliage = '\\Psbdfilesrvr.psu-erie.bd.psu.edu\student\KRJ5137\Private\Documents\PSU\Spring 2018\CMPEN 497\Final Project\FMD\image\foliage';
glass = '\\Psbdfilesrvr.psu-erie.bd.psu.edu\student\KRJ5137\Private\Documents\PSU\Spring 2018\CMPEN 497\Final Project\FMD\image\glass';
leather = '\\Psbdfilesrvr.psu-erie.bd.psu.edu\student\KRJ5137\Private\Documents\PSU\Spring 2018\CMPEN 497\Final Project\FMD\image\leather';
metal = '\\Psbdfilesrvr.psu-erie.bd.psu.edu\student\KRJ5137\Private\Documents\PSU\Spring 2018\CMPEN 497\Final Project\FMD\image\metal';
paper = '\\Psbdfilesrvr.psu-erie.bd.psu.edu\student\KRJ5137\Private\Documents\PSU\Spring 2018\CMPEN 497\Final Project\FMD\image\paper';
plastic = '\\Psbdfilesrvr.psu-erie.bd.psu.edu\student\KRJ5137\Private\Documents\PSU\Spring 2018\CMPEN 497\Final Project\FMD\image\plastic';
stone = '\\Psbdfilesrvr.psu-erie.bd.psu.edu\student\KRJ5137\Private\Documents\PSU\Spring 2018\CMPEN 497\Final Project\FMD\image\stone';
water = '\\Psbdfilesrvr.psu-erie.bd.psu.edu\student\KRJ5137\Private\Documents\PSU\Spring 2018\CMPEN 497\Final Project\FMD\image\water';
wood = '\\Psbdfilesrvr.psu-erie.bd.psu.edu\student\KRJ5137\Private\Documents\PSU\Spring 2018\CMPEN 497\Final Project\FMD\image\wood';

disp('Im Load');
allImages = [];
partTrain = [];
partTest = [];

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
    for k = 1:length(jpegFiles)
      baseFileName = jpegFiles(k).name;
      fullFileName = fullfile(myFolder, baseFileName);
      fprintf(1, 'Now reading %s\n', myFolder);
      
      imageArray = imread(fullFileName);
      if (size(imageArray,3)== 3)
          imageArray = rgb2gray(imageArray);
      end
      imageArray = imresize(imageArray,[320 240]);
      
      [len,width] = size(imageArray);
      newImage = reshape(imageArray, [1, (len*width)]);
      allImages = [allImages; i, newImage];
      
%       if (k > 90)
%           partTest = [partTest; i, newImage];
%       else
%           partTrain = [partTrain; i, newImage];
%       end
      
    end
end

disp('Write CSV');
csvwrite('ResizeTrain.csv',allImages);
% disp('Train');
% csvwrite('partTrain.csv',partTrain);
% disp('partTrain');
% csvwrite('partTest.csv',partTest);
disp('Done');
