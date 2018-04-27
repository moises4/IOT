% Seperate full wavelet dataset into train and test CSVs
clear;
clc;
close all; % closes all figures

%%
disp('Load Wavelets');
filename = 'AllWavelets.csv';
data = csvread(filename);

[row,col] = size(data);

TrainWavelet = [];
TestWavelet = [];

%%
disp('Seperate wavelets');
index=1;

for i=1:row
    
    % 90 of each category for train, 10 for test
    % Test CSV
    if(index>90)
        TestWavelet = [TestWavelet; data(i,:)];

    %  Test CSV
    else
        TrainWavelet = [TrainWavelet; data(i,:)];
    end
    
    
    if (index == 100)
        index = 1;
    else
        index = index + 1;
    end
    
end

%%
disp('Write CSV');
csvwrite('TrainWavelet.csv',TrainWavelet);
csvwrite('TestWavelet.csv',TestWavelet);

disp('Done');