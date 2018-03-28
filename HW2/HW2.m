% Author: Abdallah S. Abdallah aua639@psu.edu
% HW2_template.m - Version: 0.2


clear;
clc;
close all; % closes all figures

%% Load the dataset

% I already used Matlab GUI to generatre the function
% (importfileAsColVectors) and uploaded it to the homework folder as well
[emotion,pixels,Usage] = importfileAsColVectors('fer2013.csv',2, 35888 );

pixelsChars = char(pixels);

tic
pixelsData_chunk1 = str2num(pixelsChars(1:10000,:));
toc

%% ToDO by students: repeat partitionin and processing until you extract all data pixels
pixelsData_chunk2 = str2num(pixelChars(10001:20000,:));

pixelsData_chunk3 = str2num(pixelChars(20001:30000,:));

pixelsData_chunk4 = str2num(pixelChars(30001:35888,:));

%% ToDO by students:use matlab syntax to combine the pixels data
%% be smart and save the pixels data as well before you actually use it for
%% wavelets calculations, so that if you suffer any crashes, you never need
%% to rerun the .csv reading and parsing code again

allPixelData = [pixelsData_chunk1; pixelsData_chunk2; pixelsData_chunk3; pixelsData_chunk4];

%% ToDO by students:Loop over each row to execute
% restructure each row into 2D Image matrix
% apply wavelet analysis to level 1
% repeat wavelet analysis as you desire
% choose and combine the wavelets coefficients that you like
% concatenate the chosen subset of coefficients into single row format

disp('Preprocessing images. This will take a while...');

processedImages = [];
                                
for i = 1:allPixelData                                                   
    reshapedImage = reshape(images(i, 2:end), [48,48])'; % Reshape image into 48x48 matrix
    downSampledImage = reshapedImage(1:2:end, 1:2:end); % Down sample matrix into 24x24 matrix
    
    %%Wavelet extraction occurs here
    [a, h, v, d] = haart2(downSampledImage, 2);
        
    waveletImage = reshape(a,[1,576]);
    
    processedImages = [processedImages; waveletImage];
    
    
    if (mod(i, 1000) == 0)
        fprintf('%d out of %d images processed\n', i, totalDataSize);
    end
end

%% ToDO by students: after loopoing , save the wavelets data structure as a preprocessed 
% dataaset so that you can also use it in future without going through 
% all previous steps again


%% ToDO by students: Now continue the homework on your own, you should not 
% need more guidance