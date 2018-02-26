% Clear output
clear;
clc;

close all; % closes all figures


%% data formatting
% fer2013.csv - training data
% test.csv - test data for submission

disp('loading data ...............');

% The training set is  42000 samples
% testing set is 28,000  samples
fileID = fopen("fer2013.csv");
trainingSize = 28709;
testingSize = 7178;
totalDataSize = trainingSize + testingSize;

disp('Sample data opened!');

disp('Extracting data...........');
% Grab the headers from the original data set
headers = textscan(fileID, '%s %s %s', 1, 'delimiter',',');

% Grab all data from the original data set
data = textscan(fileID, '%d %s %s', (trainingSize + testingSize), 'delimiter', ',');
disp('Data extracted!');



%%Grab training data
trainTempImages = [];
trainEmotions = [];
trainImages = [];

disp('Parsing emotion values and pixel values for training data...........');
% Sort out the data array to grab the emotion values and the pixel values
for i=1:trainingSize
    trainTempImages = [trainTempImages; data{1, 2}(i)];
    trainEmotions = [trainEmotions; data{1, 1}(i)];
end
disp('Emotion values and pixel values parsed!');

disp('Creating final array of pixel values for training data.........');
% Create the final array of emotions with pixel values
for b=1:trainingSize
    pic1 = string(trainTempImages{b,1}); % Convert each line of pixels into a string
    pic2 = str2double(strsplit(pic1)); % Parse the string by whitespaces
    trainImages = [trainImages; uint8(trainEmotions(b, 1)), uint8(pic2)]; % Convert emotions and pixel values into unsigned 8 bit integer, add to array
    if (mod(b, 1000) == 0)
        fprintf('%d out of %d training images processed\n', b, trainingSize);
    end
end
disp('Final array for training data created!');
%% Grab testing data
% Sort out the data array to grab the emotion values and the pixel values


testTempImages = [];
testEmotions = [];
testImages = [];

disp('Parsing emotion values and pixel values for testing data...........');
for i=trainingSize+1:totalDataSize
    testTempImages = [testTempImages; data{1, 2}(i)];
    testEmotions = [testEmotions; data{1, 1}(i)];
end
disp('Emotion values and pixel values parsed!');

disp('Creating final array of pixel values for testing data.........');
% Create the final array of emotions with pixel values
for b=1:testingSize
    pic1 = string(testTempImages{b,1}); % Convert each line of pixels into a string
    pic2 = str2double(strsplit(pic1)); % Parse the string by whitespaces
    testImages = [testImages; uint8(testEmotions(b, 1)), uint8(pic2)]; % Convert emotions and pixel values into unsigned 8 bit integer, add to array
    if (mod(b, 1000) == 0)
        fprintf('%d out of %d testing images processed\n', b, testingSize);
    end
end
disp('Final array for testing data created!');
disp('All data loaded!');