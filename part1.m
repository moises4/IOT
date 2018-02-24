%%
close all; clear all;

img   = imread('./data/motorcycle.bmp');
img= rgb2gray(img);
img = imresize(img,[360, 410]);


img   = fftshift(img(:,:,1));
F     = fft2(double(img));

magA = 100*log(1+abs(fftshift(F)));
figure; imagesc(magA); colormap(gray); title('magnitude spectrum');

phiA = angle(F);
figure; imagesc(phiA);  colormap(gray); title('phase spectrum');

%%
img2   = imread('./data/fish.bmp');
img2   = rgb2gray(img2);
img2   = imresize(img2,[360, 410]);


img   = fftshift(img2(:,:,1));
F2     = fft2(double(img2));

magB = 100*log(1+abs(fftshift(F2)));
figure; imagesc(magB); colormap(gray); title('magnitude spectrum');

phiB = angle(F2);
figure; imagesc(phiB);  colormap(gray); title('phase spectrum');


%%
%Switch magnitude and phase of 2D FFTs
fftC = magA.*exp(1i.*phiB);
fftD = magB.*exp(1i.*phiA);

imageC = ifft2(fftC);
imageD = ifftshift(ifft2(fftD));


figure, imshow((imageC)), colormap gray
title('Image C  Magnitude')
figure, imshow((imageD)), colormap(gray); 
title('Image D  Magnitude')


