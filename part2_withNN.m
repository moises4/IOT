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
fileID = fopen('fer2013.csv', 'r');
trainingSize = 50;
testingSize = 10;
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
    testImages = [testImages;  uint8(testEmotions(b, 1)), uint8(pic2)]; % Convert emotions and pixel values into unsigned 8 bit integer, add to array
    if (mod(b, 1000) == 0)
        fprintf('%d out of %d testing images processed\n', b, testingSize);
    end
end
disp('Final array for testing data created!');
disp('All data loaded!');

images = [trainImages; testImages];
disp('Training and testing arrays successfully combined!');

% The first column is the label that shows the correct emotion for each sample in the dataset,
% and each row is a sample. In the remaining columns, a row represents a 48 x 48 image of a
% facial expression.

% To visualize the digits, we need to reshape the rows
% into 48 x 48 matrices. You can use reshape for that, except that we need to transpose the 
% data, because  reshape operates by column-wise rather than row-wise.

%% Reshape the data to Visualize example for the digits sample
figure    ;                                     % plot images
colormap(gray)                                  % set to grayscale
for i = 1:25                                    % preview first 25 samples
    subplot(5,5,i)                              % plot them in 6 x 6 grid
    digit = reshape(images(i, 2:end), [48,48])';    % row = 48 x 48 image
    imagesc(digit)                              % show the image
    title(num2str(images(i, 1)))                % show the label
end


%% The labels range from 0 to 9, but we will use '10' to represent '0' because MATLAB is indexing is 1-based.

% 1 --> [1; 0; 0; 0; 0; 0; 0; 0; 0; 0]
% 2 --> [0; 1; 0; 0; 0; 0; 0; 0; 0; 0]
% 3 --> [0; 0; 1; 0; 0; 0; 0; 0; 0; 0]
%             :
% 0 --> [0; 0; 0; 0; 0; 0; 0; 0; 0; 1]
%% The dataset stores samples in rows rather than in columns, so you need to
% transpose it. Then you will partition the data so that you hold out 1/3 of the data
% for model evaluation, and you will only use 2/3 for training our artificial neural network model.

n = size(images, 1);           % number of samples in the dataset
targets  = double(images(:,1));        % 1st column is |label|
targets(targets == 0) = 7;     % use '7' to present '0'
targetsd = dummyvar(targets);  % convert label into a dummy variable
targetsd = uint8(targetsd);
% No need for the first column in the (images) set any longer
inputs = images(:,2:end);      % the rest of columns are predictors

inputs = inputs';              % transpose input
targets = targets';            % transpose target
targetsd = targetsd';         % transpose dummy variable

%% partitioning the dataset based on random selection of indices
rng(1);                             % for reproducibility
patitionObject = cvpartition(n,'Holdout',n/3);   % hold out 1/3 of the dataset

Xtrain = inputs(:, training(patitionObject));    % 2/3 of the input for training
Ytrain = targetsd(:, training(patitionObject));  % 2/3 of the target for training

Xtest = inputs(:, test(patitionObject));         % 1/3 of the input for testing
Ytest = targets(test(patitionObject));           % 1/3 of the target for testing
Ytestd = targetsd(:, test(patitionObject));      % 1/3 of the dummy variable for testing

disp('Run the Neural Network GUI Application');

%% Time to Run the Neural Network GUI Application

% type NNstart on the command prompt


%% Computing the Categorization Accuracy
% Now you are ready to use myNNfun.m to predict labels for the heldout data in Xtest and 
% compare them to the actual labels in Ytest. That gives you a realistic predictive performance against unseen data. This is also the metric Kaggle uses to score submissions.
% 
% First, you see the actual output from the network, which shows the probability 
% for each possible label. You simply choose the most probable label as your prediction 
%     and then compare it to the actual label. You should see 95% categorization accuracy.

Ypred = myNNfun(Xtest);             % predicts probability for each label
Ypred(:, 1:5)                       % display the first 5 columns
[~, Ypred] = max(Ypred);            % find the indices of max probabilities
sum(Ytest == Ypred) / length(Ytest) % compare the predicted vs. actual


% You probably noticed that the artificial neural network model generated from 
% the Pattern Recognition Tool has only one hidden layer. You can build a custom
% model with more layers if you would like, but this simple architecture is sufficient
% for most common problems.
% 
% The next question you may ask is how I picked 100 for the number of hidden neurons.
% The general rule of thumb is to pick a number between the number of input neurons,
% 784 and the number of output neurons, 10, and I just picked 100 arbitrarily. 
% That means you might do better if you try other values. 
% Let's do this programmatically this time. myNNscript.m will be handy for this
% - you can simply adapt the script to do a parameter sweep.


%% Sweeo Code Block
%% Sweeping to choose different sizes for the hidden layer

sweep = [10,50:50:500];                 % parameter values to test
scores = zeros(length(sweep), 1);       % pre-allocation
% we will use models to save the several neural network result from this
% sweep and run loop
models = cell(length(sweep), 1);        % pre-allocation
x = Xtrain;                             % inputs
t = Ytrain;                             % targets
trainFcn = 'trainscg';                  % scaled conjugate gradient
for i = 1:length(sweep)
    hiddenLayerSize = sweep(i);         % number of hidden layer neurons
    net = patternnet(hiddenLayerSize);  % pattern recognition network
    net.divideParam.trainRatio = 70/100;% 70% of data for training
    net.divideParam.valRatio = 15/100;  % 15% of data for validation
    net.divideParam.testRatio = 15/100; % 15% of data for testing
    net = train(net, x, t);             % train the network
    models{i} = net;                    % store the trained network
    p = net(Xtest);                     % predictions
    [~, p] = max(p);                    % predicted labels
    scores(i) = sum(Ytest == p) /length(Ytest);  % categorization accuracy
        
end
% Let's now plot how the categorization accuracy changes versus number of 
% neurons in the hidden layer.

figure
plot(sweep, scores, '.-')
xlabel('number of hidden neurons')
ylabel('categorization accuracy')
title('Number of hidden neurons vs. accuracy')

