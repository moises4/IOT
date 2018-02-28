close all;  clc;

img   = imread('./data/motorcycle.bmp');
img   = imresize(img,[360, 410]);
img   = double(img)/255;

img   = rgb2gray(img);


F     = fft2(img);
F     = fftshift(F); 
magA  = log(1+abs(F));
figure; imagesc(magA); colormap(gray); title('magnitude spectrum Motorcycle');

phiA = angle(F);
figure; imagesc(phiA);  colormap(gray); title('phase spectrum Motorcycle');

%%
img2   = imread('./data/fish.bmp');
img2   = rgb2gray(img2);
img2   = imresize(img2,[360, 410]);

F2     = fft2(double(img2));
F2 =    fftshift(F2);
magB = log(1+abs(F2));
figure; imagesc(magB); colormap(gray); title('magnitude spectrum Fish');

phiB = angle(F2);
figure; imagesc(phiB);  colormap(gray); title('phase spectrum Fish');


%%
%Switch magnitude and phase of 2D FFTs
fftC = magA.*exp(phiB);
fftD = magB.*exp(phiA);

imageC = ifftshift(ifft2(fftC));
imageD = ifftshift(ifft2(fftD));


figure, imshow(imageC), colormap gray
title('Image C ')
figure, imshow(imageD), colormap gray; 
title('Image D ')