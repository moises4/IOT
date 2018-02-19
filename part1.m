
close all;
clc;

imageA = imread('motorcycle.bmp');
imageB = imread('fish.bmp');


imageA = rgb2gray(imageA);
imageB = rgb2gray(imageB);


%Perform 2D FFTs
fftA = fft2(imageA);
fftB = fft2(imageB);

magA = fftA;

magB = fftB;

%Display magnitude and phase of 2D FFTs
magA = fftshift(magA);
figure; imshow(magA); title('3');
% magA = abs(magA);
% figure; imshow(magA); title('1');
% magA = log(magA+1);
figure; imshow(magA); title('2');


magB = fftshift(magB);

% magB = abs(magB);
magB = log(magB+1);
% magB = mat2gray(magB);

phiA = angle(fftshift(fftA));
phiB = angle(fftshift(fftB));


figure, imshow(magA,[24 100000]), colormap gray
title('Image A FFT2 Magnitude')
figure, imshow(phiA,[-pi pi]), colormap gray
title('Image A FFT2 Phase')
figure, imshow((magB),[24 100000]), colormap gray
title('Image B FFT2 Magnitude')
figure, imshow(phiB,[-pi pi]), colormap gray
title('Image B FFT2 Phase')

%Switch magnitude and phase of 2D FFTs
fftC = magA.*exp(1i*phiB);
fftD = magB.*exp(1i.*phiA);


