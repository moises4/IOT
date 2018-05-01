%% Instructions
% 
% example: https://www.mathworks.com/help/nnet/examples/create-simple-deep-learning-network-for-classification.html
%   we need to use a datastore to hold all of our data. The NN lets you use
%   apply different training options automatically. We can use the
%   tabularTextDatastore instead of thier imagedatastore.
% 
% Other links: https://www.mathworks.com/help/matlab/ref/matlab.io.datastore.tabulartextdatastore.html
%              https://www.mathworks.com/help/nnet/deep-learning-training-from-scratch.html
%              https://www.mathworks.com/help/vision/examples/object-detection-using-faster-r-cnn-deep-learning.html
%              https://www.mathworks.com/help/matlab/import_export/what-is-a-datastore.html
% 
%% Load data set
disp('Load Training Wavelets');
filename = 'TrainWavelets.csv';
data = csvread(filename);

% Create a tabularTextDatastore

%% CNN

layers = [
    imageInputLayer([44 55 1])
    
    convolution2dLayer(3,8,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];