clc;
clear;
close all;

%data = readtable('C:\Users\dhg5054.PSU-ERIE\Downloads\SingleWavelets.csv')


data = csvread('C:\Users\dhg5054.PSU-ERIE\Downloads\AllWavelets (2).csv');
images = data(:, 2:end);
dataSize = size(data, 1);

rootDirectory = 'C:\Users\dhg5054.PSU-ERIE\Downloads\waveletImages\';

categories = {'fabric', 'foliage', 'glass', 'leather', 'metal', 'paper', 'plastic', 'stone', 'water', 'wood'};


for i = 1:10
    mkdir(rootDirectory, char(categories(1, i)));
    filePath = strcat(rootDirectory, char(categories(1, i)));
    for k = 1:100
        fileName = strcat(filePath, '\', int2str(k), '.jpg');
        rowImage = images(((i-1) * k) + 1, 1:end);
        reshapedImage = reshape(rowImage, [40,30]);
        I = mat2gray(reshapedImage);
        imwrite(I, fileName);
    end
    
end


imageData = imageDatastore(rootDirectory,...
    'IncludeSubfolders', true,...
    'FileExtensions', '.jpg',...
    'LabelSource', 'foldernames');


layers = [
    imageInputLayer([40 30 1])
    convolution2dLayer([4 3],12)
    reluLayer
    crossChannelNormalizationLayer(4)
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(5,16)
    reluLayer
    crossChannelNormalizationLayer(4)
    maxPooling2dLayer(2,'Stride',2)
    fullyConnectedLayer(256)
    reluLayer
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm',...
    'LearnRateSchedule', 'piecewise',...
    'OutputFcn', @plotTrainingAccuracy,...
    'CheckpointPath', 'X:\IOT-master\Final Project');
[trainedNet, trainedinfo] = trainNetwork(imageData, layers, options);





