% Create a Hybrid Image between the (fish) as input#1 and the (motorcycle) as input#2.
% 1. First hybrid is the (fish) magnitude with the (motorcycle) phase
% 2. Second hybrid is the (motorcycle) magnitude and the (fish) phase
clear; close all;  clc;

%% Images
img   = imread('./data/motorcycle.bmp');
img   = imresize(img,[360, 410]);
img   = double(img)/255;
img   = rgb2gray(img);

img2   = imread('./data/fish.bmp');
img2   = imresize(img2,[360, 410]);
img2   = double(img2)/255;
img2   = rgb2gray(img2);

% imshowpair(img, img2, 'montage'); title ('Images');

%% Phase and Magnitude
% Imgradient
[m1, p1] = imgradient(img);
% imshowpair(m1, p1, 'montage'); title ('Imgradient Moto');
[m2, p2] = imgradient(img2);
% imshowpair(m2, p2, 'montage'); title ('Imgradient Fish');

% Part ii method
F1 = fftshift(fft2(double(img)));
F1_Mag = abs(F1);
F1_Phase = exp(1i*angle(F1));

F2 = fftshift(fft2(double(img2)));
F2_Mag = abs(F2);
F2_Phase = exp(1i*angle(F2));

% figure; imagesc(abs(F1_Mag)); colormap(gray); title('Magnitude Motorcycle');
% figure; imagesc(abs(F1_Phase));  colormap(gray); title('Phase Motorcycle');
% figure; imagesc(abs(F2_Mag)); colormap(gray); title('Magnitude Fish');
% figure; imagesc(abs(F2_Phase));  colormap(gray); title('Phase Fish');

%% Switch magnitude and phase of 2D FFTs
Hybrid1 = F1_Mag.*F2_Phase;
Hybrid2 = F2_Mag.*F1_Phase;

Hybrid1 = ifft2(ifftshift(Hybrid1));
Hybrid2 = ifft2(ifftshift(Hybrid2));

figure, imshow(Hybrid1), colormap gray, title('Hybrid 1');
figure, imshow(Hybrid2), colormap gray, title('Hybrid 2');

% Old method
% F1     = fftshift(fft2(double(img1)));
% magB   = log(1+abs(F2));
% phiB = angle(F2);
% F2     = fftshift(fft2(double(img2)));
% magB   = log(1+abs(F2));
% phiB = angle(F2);

% fftC = magA.*exp(phiB);
% fftD = magB.*exp(phiA);
