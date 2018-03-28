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
pixelsData_chunk2 = 

%% ToDO by students:use matlab syntax to combine the pixels data
%% be smart and save the pixels data as well before you actually use it for
%% wavelets calculations, so that if you suffer any crashes, you never need
%% to rerun the .csv reading and parsing code again


%% ToDO by students:Loop over each row to execute
% restructure each row into 2D Image matrix
% apply wavelet analysis to level 1
% repeat wavelet analysis as you desire
% choose and combine the wavelets coefficients that you like
% concatenate the chosen subset of coefficients into single row format



%% ToDO by students: after loopoing , save the wavelets data structure as a preprocessed 
% dataaset so that you can also use it in future without going through 
% all previous steps again


%% ToDO by students: Now continue the homework on your own, you should not 
% need more guidance