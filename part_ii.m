% Create and show the new image resulting from neutralizing the magnitude
% components for each the following input images separately: (dog), (Einstein), and
% fish).
clear; close all; clc;

%% Images
im1 = imread('./data/dog.bmp');
im1   = imresize(im1,[360, 410]);
im1   = double(im1)/255;
image1 = rgb2gray(im1);

im2 = imread('./data/einstein.bmp');
im2   = imresize(im2,[360, 410]);
im2   = double(im2)/255;
image2 = rgb2gray(im2); 

im3 = imread('./data/fish.bmp');
im3   = imresize(im3,[360, 410]);
im3   = double(im3)/255;
image3 = rgb2gray(im3); 

%% Fequency Domain
F1 = fftshift(fft2(image1));
F1_Mag = abs(F1);
F1_Phase = exp(1i*angle(F1));

F2 = fftshift(fft2(image2));
F2_Mag = abs(F2);
F2_Phase = exp(1i*angle(F2));

F3 = fftshift(fft2(image3));
F3_Mag = abs(F3);
F3_Phase = exp(1i*angle(F3));

%% Reconstructin

I1_Phase = ifft2(ifftshift(F1_Phase));
I2_Phase = ifft2(ifftshift(F2_Phase));
I3_Phase = ifft2(ifftshift(F3_Phase));

%% Display reconstructed images

figure,imagesc(abs(I1_Phase)), colormap gray 
title('Dog image only by Phase');

figure,imagesc(abs(I2_Phase)), colormap gray 
title('Einstein image only by Phase');

figure,imagesc(abs(I3_Phase)), colormap gray 
title('Fish image only by Phase');