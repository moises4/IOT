close all; 
clc;

im = imread('./data/dog.bmp');
image = rgb2gray(im); 

img   = fftshift(image(:,:,1));
F     = fft2(double(img));

magA = 100*log(1+abs(fftshift(F)));

I_Mag = ifft2(magA);

I_Mag_min = min(min(abs(I_Mag)));
I_Mag_max = max(max(abs(I_Mag)));
figure; imagesc(magA); colormap(gray); title('magnitude spectrum');
figure, imagesc(abs(I_Mag),[I_Mag_min I_Mag_max]), colormap gray 
title('reconstructed image only by Magnitude');