% Author: Abdallah S. Abdallah aua639@psu.edu
% HW2_template.m - Version: 0.2

clear;
clc;
close all; % closes all figures

%% Load the dataset

% I already used Matlab GUI to generatre the function
% (importfileAsColVectors) and uploaded it to the homework folder as well
disp('Load CSV');
[emotion,pixels,Usage] = importfileAsColVectors('C:\Users\dhg5054.PSU-ERIE\Downloads\fer2013.csv',2, 35888 );
csvwrite('emotionLabels.csv', emotion);
pixelsChars = char(pixels);
disp('process complete');

%% ToDO by students: repeat partitionin and processing until you extract all data pixels
disp('str2num');
totalDataSize = 35887;

% pixelsData_Test = str2num(pixelsChars(1:1000,:));

% tic
pixelsData_chunk1 = str2num(pixelsChars(1:10000,:));
pixelsData_chunk2 = str2num(pixelsChars(10001:20000,:));
pixelsData_chunk3 = str2num(pixelsChars(20001:30000,:));
pixelsData_chunk4 = str2num(pixelsChars(30001:35887,:));
% toc
disp('process complete');

%% ToDO by students:use matlab syntax to combine the pixels data
%% be smart and save the pixels data as well before you actually use it for
%% wavelets calculations, so that if you suffer any crashes, you never need
%% to rerun the .csv reading and parsing code again

% allPixelData = pixelsData_Test;
newpixels_Chunk1 = (pixelsData_chunk1 - mean(pixelsData_chunk1))/std(pixelsData_chunk1);
newpixels_Chunk2 = (pixelsData_chunk2 - mean(pixelsData_chunk2))/std(pixelsData_chunk2);
newpixels_Chunk3 = (pixelsData_chunk3 - mean(pixelsData_chunk3))/std(pixelsData_chunk3);
newpixels_Chunk4 = (pixelsData_chunk4 - mean(pixelsData_chunk4))/std(pixelsData_chunk4);

allPixelData = [newpixels_Chunk1 newpixels_Chunk2 newpixels_Chunk3 newpixels_Chunk4];

%% ToDO by students:Loop over each row to execute
% restructure each row into 2D Image matrix
% apply wavelet analysis to level 1
% repeat wavelet analysis as you desire
% choose and combine the wavelets coefficients that you like
% concatenate the chosen subset of coefficients into single row format

disp('Preprocessing images. This will take a while...');

sym2Processed = [];
db2Processed = [];
                                
for i = 1:totalDataSize                                                   
    reshapedImage = reshape(allPixelData(i, 1:end), [48,48])'; % Reshape image into 48x48 matrix
%     downSampledImage = reshapedImage(1:2:end, 1:2:end); % Down sample matrix into 24x24 matrix
    reshapedImage = imrotate(reshapedImage,90);
    
    %%Haar Wavelet
    wname = 'sym2';
    [a, h, v, d] = dwt2(reshapedImage,wname);
    len = length(a);    
    waveletImage = reshape(a,[1,len*len]);
    sym2Processed = [sym2Processed; waveletImage];
    
    
    %%Daubechies Wavelet
    wname = 'db2';
    [a, h, v, d] = dwt2(reshapedImage,wname);
    len2 = length(a);    
    waveletImage = reshape(a,[1,len2*len2]);
    dbProcessed = [dbProcessed; waveletImage];
    
    
    if (mod(i, 1000) == 0)
        fprintf('%d out of %d images processed\n', i, totalDataSize);
    end
end

disp('process complete');

disp('Display Images');
figure;                                         % plot images
colormap(gray)                                  % set to grayscale
for i = 1:25                                    % preview first 25 samples
    subplot(5,5,i)                              % plot them in 6 x 6 grid
    digit = reshape(haarProcessed(i, 1:end), [len,len])';    % row = 48 x 48 image
    imagesc(digit)                              % show the image
    title(num2str(haarProcessed(i, 1)))                % show the label
end

figure;                                         % plot images
colormap(gray)                                  % set to grayscale
for i = 1:25                                    % preview first 25 samples
    subplot(5,5,i)                              % plot them in 6 x 6 grid
    digit = reshape(dbProcessed(i, 1:end), [len2,len2])';    % row = 48 x 48 image
    imagesc(digit)                              % show the image
    title(num2str(dbProcessed(i, 1)))                % show the label
end


%% ToDO by students: after loopoing , save the wavelets data structure as a preprocessed 
% dataaset so that you can also use it in future without going through 
% all previous steps again

csvwrite('sym2Data.csv',sym2Processed)

csvwrite('db2Data.csv',dbProcessed)

%% ToDO by students: Now continue the homework on your own, you should not 
% need more guidance
