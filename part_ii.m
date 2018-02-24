close all; clc;

im1 = imread('./data/dog.bmp');
image1 = rgb2gray(im1);

im2 = imread('./data/einstein.bmp');
image2 = rgb2gray(im2); 

im3 = imread('./data/fish.bmp');
image3 = rgb2gray(im3); 

%% Fequency Domain
F1 = fft2(double(image1));
F_Mag1 = abs(F1);
F_Phase1 = exp(1i*angle(F1));

F2 = fft2(double(image2));
F_Mag2 = abs(F2);
F_Phase2 = exp(1i*angle(F2));

F3 = fft2(double(image3));
F_Mag3 = abs(F3);
F_Phase3 = exp(1i*angle(F3));

%% Reconstructin

I_Phase1 = ifft2(F_Phase1);
I_Phase2 = ifft2(F_Phase2);
I_Phase3 = ifft2(F_Phase3);

%% Display reconstructed images

figure,imagesc(abs(I_Phase1)), colormap gray 
title('Dog image only by Phase');

figure,imagesc(abs(I_Phase2)), colormap gray 
title('Einstein image only by Phase');

figure,imagesc(abs(I_Phase3)), colormap gray 
title('Fish image only by Phase');