% Create and show the new image resulting from neutralizing the magnitude
% components for each the following input images separately: (dog), (Einstein), and
% fish).
clear; close all; clc;

%% Images
disp('Display Images');
tic;
im1 = imread('./data/dog.bmp');
im1   = imresize(im1,[360, 410]);
im1   = double(im1)/255;
im1 = rgb2gray(im1);
toc;
im2 = imread('./data/einstein.bmp');
im2   = imresize(im2,[360, 410]);
im2   = double(im2)/255;
im2 = rgb2gray(im2); 
toc;



im3 = imread('./data/fish.bmp');
im3   = imresize(im3,[360, 410]);
im3   = double(im3)/255;
im3 = rgb2gray(im3); 
toc;
disp(' ');

%% Fequency Domain
tic;
disp('fftshifts');
F1 = fftshift(fft2(im1));
F2 = fftshift(fft2(im2));
F3 = fftshift(fft2(im3));
toc;
disp(' ');
% Neutralize Magnitude
tic;
disp('Neutralize Magnitudes');
F1_Mag = 1;
F2_Mag = 1;
F3_Mag = 1;
toc;
disp(' ');

tic;
disp('Phases');
% Phase
F1_Phase = exp(1i*angle(F1));
F2_Phase = exp(1i*angle(F2));
F3_Phase = exp(1i*angle(F3));

toc;



disp(' ');



%% Reconstructin

tic;
disp('Recontruction');
Reconstruct1 = log(abs(ifft2(ifftshift(F1_Mag.*F1_Phase)))+1);
Reconstruct2 = log(abs(ifft2(ifftshift(F2_Mag.*F2_Phase)))+1);
Reconstruct3 = log(abs(ifft2(ifftshift(F3_Mag.*F3_Phase)))+1);

toc;

disp(' ');
%% Display reconstructed images

tic;
disp('Display Images');
figure;
subplot (2,2,1), imagesc(Reconstruct1), colormap gray, axis off, title('Dog Magnitude Neutralize');
toc;
subplot (2,2,2), imagesc(Reconstruct2), colormap gray, axis off, title('Einstein Magnitude Neutralize');
toc;
subplot (2,2,3), imagesc(Reconstruct3), colormap gray, axis off, title('Fish Magnitude Neutralize');
toc;
