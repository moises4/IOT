% Create a Hybrid Image between the (fish) as input#1 and the (motorcycle) as input#2.
% 1. First hybrid is the (fish) magnitude with the (motorcycle) phase
% 2. Second hybrid is the (motorcycle) magnitude and the (fish) phase
clear; close all;  clc;

%% Images
disp('Open Images');
tic;
im1   = imread('./data/motorcycle.bmp');
im1   = imresize(im1,[360, 410]);
im1   = double(im1)/255;
im1   = rgb2gray(im1);
toc;
tic;
im2   = imread('./data/fish.bmp');
im2   = imresize(im2,[360, 410]);
im2   = double(im2)/255;
im2   = rgb2gray(im2);
toc;
disp('End open images');

%% Fequency Domain


disp(' ');
tic;
disp('fftshits');
F1 = fftshift(fft2(im1));
F2 = fftshift(fft2(im2));
toc;

disp(' ');
tic;
disp('Neutralize Magnitude');
% Neutralize Magnitude
F1_Mag = abs(F1);
F2_Mag = abs(F2);

toc;
disp(' ');

tic;
disp('Phase');
% Phase
F1_Phase = exp(1i*angle(F1));
F2_Phase = exp(1i*angle(F2));
toc;
disp(' ');
%% Reconstructin

tic;
disp('Reconstruct');
Reconstruct1 = log(abs(ifft2(ifftshift(F2_Mag.*F1_Phase)))+1);
Reconstruct2 = log(abs(ifft2(ifftshift(F1_Mag.*F2_Phase)))+1);
toc;
disp(' ');
%% Display reconstructed images

tic;
disp('Display Images');
figure;
subplot (1,2,1), imagesc(Reconstruct1), colormap gray, axis off, title('Fish magnitude with motorcycle phase');
subplot (1,2,2), imagesc(Reconstruct2), colormap gray, axis off, title('Motorcycle magnitude with fish phase');
toc;
