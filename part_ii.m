close all; clc;
im = imread('./data/dog.bmp');
image = rgb2gray(im); 

%% Take the Phase
F = fft2(double(image));
F_Mag = abs(F);
F_Phase = exp(1i*angle(F));

%% reconstructin

I_Phase = ifft2(F_Phase);

%% Display reconstructed images

figure,imagesc(abs(I_Phase)), colormap gray 
title('reconstructed image only by Phase');