% Create and show the new image resulting from removing the phase components for
% each the following input images separately: (dog), (motorcycle), and (submarine).
clear; close all; clc;

%% Images
tic;
disp('Display images');
im1 = imread('./data/dog.bmp');
im1   = imresize(im1,[360, 410]);
im1   = double(im1)/255;
im1 = rgb2gray(im1);
toc;

im2 = imread('./data/motorcycle.bmp');
im2   = imresize(im2,[360, 410]);
im2   = double(im2)/255;
im2 = rgb2gray(im2); 
toc;

im3 = imread('./data/submarine.bmp');
im3   = imresize(im3,[360, 410]);
im3   = double(im3)/255;
im3 = rgb2gray(im3); 
toc;
disp(' ');


%% Frequency Domain
tic;
disp('Frequency Domain');
F1 = fftshift(fft2(double(im1)));
F2 = fftshift(fft2(double(im2)));
F3 = fftshift(fft2(double(im3)));
toc;
disp(' ');

% Magnitude
tic;
disp('Magnitude');
F1_Mag = abs(F1);
F2_Mag = abs(F2);
F3_Mag = abs(F3);
toc;
disp(' ');

%% Neutralize Phase
tic;
disp('Neutralize Phase');
F1_Phase = exp(1i*0);
F2_Phase = exp(1i*0);
F3_Phase = exp(1i*0);
toc;
disp(' ');


%% Reconstructin
tic;
disp('Reconstruct');
Reconstruct1 = log(abs(ifft2(ifftshift(F1_Mag.*F1_Phase)))+1);
Reconstruct2 = log(abs(ifft2(ifftshift(F2_Mag.*F2_Phase)))+1);
Reconstruct3 = log(abs(ifft2(ifftshift(F3_Mag.*F3_Phase)))+1);
toc;

%% Display reconstructed images
tic;
disp('Display Final Images');
figure;
subplot (2,2,1), imagesc(Reconstruct1), colormap gray, axis off, title('Dog Phase Neutralize');
toc;
subplot (2,2,2), imagesc(Reconstruct2), colormap gray, axis off, title('Einstein Phase Neutralize');
toc;
subplot (2,2,3), imagesc(Reconstruct3), colormap gray, axis off, title('Fish Phase Neutralize');
toc;
