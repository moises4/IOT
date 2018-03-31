% Author: Abdallah S. Abdallah aua639@psu.edu
% HW2_template.m - Version: 0.2

clear;
clc;
close all; % closes all figures

%% Load the dataset

% I already used Matlab GUI to generatre the function
% (importfileAsColVectors) and uploaded it to the homework folder as well
disp('Load CSV');
[emotion,pixels,Usage] = importfileAsColVectors('fer2013.csv',2, 35887 );
pixelsChars = char(pixels);

%% ToDO by students: repeat partitionin and processing until you extract all data pixels
disp('str2num');
totalDataSize = 35888;

% pixelsData_Test = str2num(pixelsChars(1:50,:));

% tic
pixelsData_chunk1 = str2num(pixelsChars(1:10000,:));
pixelsData_chunk2 = str2num(pixelsChars(10001:20000,:));
pixelsData_chunk3 = str2num(pixelsChars(20001:30000,:));
pixelsData_chunk4 = str2num(pixelsChars(30001:35887,:));
% toc

%% ToDO by students:use matlab syntax to combine the pixels data
%% be smart and save the pixels data as well before you actually use it for
%% wavelets calculations, so that if you suffer any crashes, you never need
%% to rerun the .csv reading and parsing code again

% allPixelData = pixelsData_Test;
allPixelData = [pixelsData_chunk1; pixelsData_chunk2; pixelsData_chunk3; pixelsData_chunk4];

%% ToDO by students:Loop over each row to execute
% restructure each row into 2D Image matrix
% apply wavelet analysis to level 1
% repeat wavelet analysis as you desire
% choose and combine the wavelets coefficients that you like
% concatenate the chosen subset of coefficients into single row format

disp('Preprocessing images. This will take a while...');

dbProcessed = [];
coifProcessed = [];
                                
for i = 1:totalDataSize                                                   
    reshapedImage = reshape(allPixelData(i, 1:end), [48,48])'; % Reshape image into 48x48 matrix
%     downSampledImage = reshapedImage(1:2:end, 1:2:end); % Down sample matrix into 24x24 matrix
%     reshapedImage = imrotate(reshapedImage,90);
    
    %%Daubechies Wavelet
    wname = 'db1';
    [a, h, v, d] = dwt2(reshapedImage,wname);
    len1 = length(a);    
    waveletImage = reshape(a,[1,len1*len1]);
    dbProcessed = [dbProcessed; waveletImage];
    
%     imagesc(a);
%     title('Daubechies');
    
    %%Coiflets Wavelet
    wname = 'coif1';
    [a, h, v, d] = dwt2(reshapedImage,wname);
    len2 = length(a);    
    waveletImage = reshape(a,[1,len2*len2]);
    coifProcessed = [coifProcessed; waveletImage];
    
%     imagesc(a);
%     title('Coiflets');
   
end

disp('Display Images');
figure;                                         % plot images
colormap(gray)                                  % set to grayscale
for i = 1:25                                    % preview first 25 samples
    subplot(5,5,i)                              % plot them in 6 x 6 grid
    digit = reshape(dbProcessed(i, 1:end), [len1,len1])';    % row = 48 x 48 image
    digit = imrotate(digit,270);
    imagesc(digit)                              % show the image
    title(num2str(dbProcessed(i, 1)))                % show the label
end

figure;                                         % plot images
colormap(gray)                                  % set to grayscale
for i = 1:25                                    % preview first 25 samples
    subplot(5,5,i)                              % plot them in 6 x 6 grid
    digit = reshape(coifProcessed(i, 1:end), [len2,len2])';    % row = 48 x 48 image
    digit = imrotate(digit,270);
    imagesc(digit)                              % show the image
    title(num2str(coifProcessed(i, 1)))                % show the label
end

%% ToDO by students: after loopoing , save the wavelets data structure as a preprocessed 
% dataaset so that you can also use it in future without going through 
% all previous steps again

disp('Write CSV');

csvwrite('dbData.csv',dbProcessed);
csvwrite('coifData.csv',coifProcessed);

disp('process complete');

%% ToDO by students: Now continue the homework on your own, you should not 
% need more guidance