% % % Author: Abdallah S. Abdallah aua639@psu.edu
% % 
% % 
% % clear;
% % clc;
% % 
% % close all; % closes all figures
% % 
% % %% Setup
% % ogbW = imread('./data/marilyn.bmp');
% % originalBW = rgb2gray(ogbW);
% % imshow(originalBW);
% % 
% % se = strel('rectangle', [10 30]);
% % dilateBW = imdilate(originalBW,se);
% % figure, imshow(dilateBW);title('dilateBW');
% % 
% % 
% % erodeBW = imerode(originalBW,se);
% % figure, imshow(erodeBW); title('erodeBW');
% % 
% % 
% % openBW = imopen(originalBW,se);
% % figure, imshow(openBW); title('openBW');
% % 
% % 
% % closeBW = imclose(originalBW,se);
% % figure, imshow(closeBW); title('closeBW');
% % 
% % %% Using SE = strel('square',W)
% % disp('hit any key to continue');
% % pause;
% % 
% % se = strel('octagon',21);
% % dilateBW = imdilate(originalBW,se);
% % figure, imshow(dilateBW);title('dilateBW');
% % 
% % 
% % erodeBW = imerode(originalBW,se);
% % figure, imshow(erodeBW); title('erodeBW');
% % 
% % 
% % openBW = imopen(originalBW,se);
% % figure, imshow(openBW); title('openBW');
% 
% 
% closeBW = imclose(originalBW,se);
% figure, imshow(closeBW); title('closeBW');

%% Lab 2
clear;
clc;

close all; % closes all figures

ogbW = imread('./data/dog.bmp');
originalBW = rgb2gray(ogbW);
imshow(originalBW);

out10 = imresize(originalBW, 2, 'nearest');
out11 = imresize(originalBW, 2, 'bilinear');
out12 = imresize(originalBW, 2, 'bicubic');

out14 = edge(out10, 'Canny');
out15 = edge(out11, 'Canny');
out16 = edge(out12, 'Canny');

figure; imshow(out14);


se = strel('disk',10);
closeBW = imclose(out14,se);
figure, imshow(closeBW); title('closeBW');
closeBW1 = imclose(out15,se);
figure, imshow(closeBW); title('closeBW1');
closeBW2 = imclose(out16,se);
figure, imshow(closeBW); title('closeBW2');



out1 = imfill(closeBW, 'holes');
mul1 = immultiply(out10, out1);
figure; imshow(mul1);

%% lab 3
% 
clear;
clc;

close all; % closes all figures


% read images and convert to floating point format
image1 = imread('./data/marilyn.bmp');
image2 = imread('./data/cat.bmp');
image3 = imread('./data/submarine.bmp');
image4 = imread('./data/bicycle.bmp');

image1_gray = rgb2gray(image1);
image2_gray = rgb2gray(image2);
image3_gray = rgb2gray(image3);
image4_gray = rgb2gray(image4);

im1 = imresize(image1_gray, [360,410]);
im2 = imresize(image2_gray, [360,410]);
im3 = imresize(image3_gray, [360,410]);
im4 = imresize(image4_gray, [360,410]);

out1 = cat(1, im1, im3);
out2 = cat(1, im2, im4);
out3 = cat(2, out1, out2);

out5 = imresize(out3, 2, 'nearest');
out6 = imresize(out3, 2, 'bilinear');
out7 = imresize(out3, 2, 'bicubic');

out8 = edge(out5, 'Canny');
out9 = edge(out6, 'Canny');
out10 = edge(out7, 'Canny');



se = strel('disk',10);
closeBW = imclose(out8,se);
figure, imshow(closeBW); title('closeBW');
closeBW1 = imclose(out9,se);
figure, imshow(closeBW); title('closeBW1');
closeBW2 = imclose(out10,se);
figure, imshow(closeBW); title('closeBW2');


out11 = imfill(closeBW, 'holes');
mul1 = immultiply(out5, out11);
figure; imshow(mul1);


out12 = imfill(closeBW, 'holes');
mul1 = immultiply(out6, out12);
figure; imshow(mul1);


out13 = imfill(closeBW, 'holes');
mul1 = immultiply(out7, out13);
figure; imshow(mul1);
