
% Author: Abdallah S. Abdallah aua639@psu.edu
% SamplingDemo_Incomplete - Version: 0.1


clear;
clc;

close all; % closes all figures

%% Setup
% read images and convert to floating point format
image1 = imread('dog.bmp');
image2 = imread('cat.bmp');
image3 = imread('bird.bmp');
image4 = imread('fish.bmp');



image1double = double (image1)/255;
image2double = double (image2)/255;

image1_gray = rgb2gray(image1);
image2_gray = rgb2gray(image2);
%figure;imshowpair(image1_gray, image2_gray, 'montage');

out1 = zeros(floor(size(image1_gray,1)/2), floor(size(image1_gray,2)/2));




% Down sampling by a factor of two
out1 = image1_gray(1:2:end, 1:2:end);

%figure;imshow(out1);

%% alternative downsample method.

out11 = imresize(image1_gray,0.5);
%figure;imshow(out11);

%% Class Sampling Lab1 
% Create an Upsampler with a factor of two using the imresize function
%figure;imshow(imresize(image1_gray, 2));


%% Implement Sampling Lab2
image3_gray = rgb2gray(image3);
image4_gray = rgb2gray(image4);
im1 = imresize(image1_gray,[360, 410]);
im2 = imresize(image2_gray,[360, 410]);
im3 = imresize(image3_gray,[360, 410]);
im4 = imresize(image4_gray,[360, 410]);

%montage([im2, im3; im4, im1]);

combineIMG = [im2, im3; im4, im1];


%imshow(combineIMG);

%% Implement Sampling Lab3

figure;imshow(combineIMG);
title('OG');


imr1 = imresize(combineIMG, 0.5, 'nearest');

imr2 = imresize(combineIMG, 0.5, 'bilinear');

imr3 = imresize(combineIMG, 0.5, 'bicubic');

figure;imshow(imresize(combineIMG, 0.5) - imr1);
title('OG - nearest');

figure;imshow(imresize(combineIMG, 0.5) - imr2);
title('OG - bilinear');

figure;imshow(imresize(combineIMG, 0.5) - imr3);
title('OG - bicubic');

% figure;imshow(imr1);
% title('Nearest');
% 
% figure;imshow(imresize(combineIMG, 0.5, 'bilinear'));
% title('Bilinear');
% 
% figure;imshow(imresize(combineIMG, 0.5, 'bicubic'));
% title('Bicubic');

%% Upscaling
imr0 = imresize(combineIMG, 2);

imr1 = imresize(combineIMG, 2, 'nearest');

imr2 = imresize(combineIMG, 2, 'bilinear');

imr3 = imresize(combineIMG, 2, 'cubic');

figure;imshow(edge(imr0,'canny'));
title('2 time resize Normal');

figure;imshow(edge(imr1,'canny'));
title('2 time resize nearest');

figure;imshow(edge(imr2,'canny'));
title('2 time resize bilinear');

figure;imshow(edge(imr3,'canny'));
title('2 time resize cubic');

%% In frequency domain
% fftsize = 1024;
%im1_fft  = fftshift(fft2(combineIMG,  fftsize, fftsize));   % 1) fft im with padding
% im1_fft2 = fft2(combineIMG,fftsize,fftsize);
% 
% im1_fft = fftshift(log(1+abs(im1_fft2)));

% im2_fft = imresize(im1_fft,.5,'nearest');
% 
% im3_fft = imresize(im1_fft,.5,'bilinear');
% 
% im4_fft = imresize(im1_fft,.5,'bicubic');
% 
% differences1 = im2_fft-imresize(im1_fft,.5);
% 
% differences2 = im3_fft-imresize(im1_fft,.5);
% 
% differences3 = im4_fft-imresize(im1_fft,.5);



% figure;imshow(im1_fft, []);
% title('OG');
% 
% figure;imshow(imresize (im1_fft, .5, 'nearest'), []);
% title('Neighbor');
% 
% figure;imshow(imresize (im1_fft, .5, 'bilinear'), []);
% title('Bilinear');
% 
% figure;imshow(imresize (im1_fft, .5, 'bicubic'), []);
% title('Bicubic');
% 
% figure;imshow(differences1);
% title('Neighbor - Normal');
% 
% figure;imshow(differences2);
% title('Bilinear - Normal');
% 
% figure;imshow(differences3);
% title('Bicubic - Normal');




