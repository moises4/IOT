close all; 
clc;

%% dog lol
im = imread('./data/dog.bmp'); 
im = double(im)/255;
im = rgb2gray(im);

F  = fft2(im);
F  = fftshift(F);

magA = (abs(F));

I_Mag = ifft2(ifftshift(magA));

figure, imshow(I_Mag), colormap gray;
title('Dog reconstructed only by Magnitude');

%% Einstein
im2 = imread('./data/Einstein.bmp'); 
im2 = double(im2)/255;
im2 = rgb2gray(im2);

F2  = fft2(im2);
F2  = fftshift(F2);

magB = (abs(F2));

I_Mag2 = ifft2(ifftshift(magB));

figure, imshow(I_Mag2), colormap gray;
title('Einstein reconstructed only by Magnitude');


%% Fish
im3 = imread('./data/fish.bmp'); 
im3 = double(im3)/255;
im3 = rgb2gray(im3);

F3  = fft2(im3);
F3  = fftshift(F3);

magC = (abs(F3));

I_Mag3 = ifft2(ifftshift(magC));

figure, imshow(I_Mag3), colormap gray;
title('Fish reconstructed only by Magnitude');