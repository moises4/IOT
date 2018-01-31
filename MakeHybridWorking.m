% Author: Abdallah S. Abdallah aua639@psu.edu
% MakeHybrid - Version: 0.1

clear;
clc;
close all; % closes all figures

%% Setup
% read images and convert to floating point format
image1 = imread('./data/cat.bmp');
image2 = imread('./data/dog.bmp');

figure;imshowpair(image1, image2, 'montage');

image1double = double (image1)/255;
image2double = double (image2)/255;

im1 = rgb2gray(image1double);
im2 = rgb2gray(image2double);

[im1h, im1w] = size(im1);
[im2h, im2w] = size(im2);

hs = 50; % filter half-size
fil = fspecial('gaussian', hs*2+1, 10); 
% fil = fspecial('sobel', hs*2+1, 10); 
 
fftsize = 1024; % should be order of 2 (for speed) and include padding

%% Frequency Domain on input images
im1_fft  = fftshift(fft2(im1,  fftsize, fftsize));                    % 1) fft im with padding
im2_fft  = fftshift(fft2(im2,  fftsize, fftsize));                    % 1) fft im with padding
figure;imshow(im1_fft);
figure;imshow(im2_fft);


radius_size = 50;

%%% LPF on im1 (Black except for center)
im1_copy = im1_fft;
[m,n] = size(im1_copy);
center_m = m/2;
center_n = n/2;

for i=1:m
    for j=1:n
        
        Dist_Matrix = [center_m, center_n; i, j];
        Dist = pdist(Dist_Matrix, 'euclidean');
        if Dist >= radius_size
            im1_copy(i,j)= 0;
        end
        
    end
end
figure;imshow(im1_copy);

%%% HPF on im2 (Black center)
im2_copy = im2_fft;
[m,n] = size(im2_copy);
center_m = m/2;
center_n = n/2;

for i=1:m
    for j=1:n
        
        Dist_Matrix = [center_m, center_n; i, j];
        Dist = pdist(Dist_Matrix, 'euclidean');
        if Dist <= radius_size
            im2_copy(i,j)= 0;
        end
        
    end
end
figure;imshow(im2_copy);


%% Pad images
% fil_fft = fft2(fil, fftsize, fftsize);                  % 2) fft fil, pad to same size as image
% im1_fil_fft = im1_copy .* fil_fft;                       % 3) multiply fft images
% im2_fil_fft = im2_copy .* fil_fft;                       % 3) multiply fft images
% figure;imshow(im1_fil_fft);
% figure;imshow(im2_fil_fft);


% final_fft_im = im1_fil_fft + im2_fil_fft;
% figure;imshow(final_fft_im);

% im_final = ifft2(ifftshift(final_fft_im));                      % 4) inverse fft2
% im_final = im_final(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs); % 5) remove padding

% figure; imshow(im_final);



final_fft_im2 = im1_copy + im2_copy;
% final_fft_im2 = ifftshift(im1_copy) + ifftshift(im2_copy);
figure;imshow(final_fft_im2);

im_final2 = ifft2((final_fft_im2));
% im_final2 = ifft2(final_fft_im2);
figure; imshow(im_final2);
im_final2 = im_final2(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs); % 5) remove padding
figure; imshow(im_final2);
        
