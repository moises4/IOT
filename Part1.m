% Create a Hybrid Image between the (fish) as input#1 and the (motorcycle) as input#2.
% 1. First hybrid is the (fish) magnitude with the (motorcycle) phase
% 2. Second hybrid is the (motorcycle) magnitude and the (fish) phase
close all;  clc;
disp('Load and resize both images');
tic;
% Images
img   = imread('motorcycle.bmp');
img   = imresize(img,[360, 410]);
img   = double(img)/255;
img   = rgb2gray(img);

img2   = imread('fish.bmp');
img2   = imresize(img2,[360, 410]);
img2   = double(img2)/255;
img2   = rgb2gray(img2);
toc;

disp('Show pair');
tic;
imshowpair(img, img2, 'montage'); title ('Images');
toc;
% Phase and Magnitude
% Imgradient
disp('imgradient2');
tic;
[m1, p1] = imgradient(img);
toc;

% imshowpair(m1, p1, 'montage'); title ('Imgradient Moto');
disp('imgradient');
tic;
[m2, p2] = imgradient(img2);
toc;
% imshowpair(m2, p2, 'montage'); title ('Imgradient Fish');

% Part ii method
disp('F1 fftshift');
tic;
F1 = fftshift(fft2(double(img)));
toc;

disp('F1_mag');
tic;
F1_Mag = abs(F1);
toc;

disp('F1_Phase');
tic;
F1_Phase = exp(1i*angle(F1));
toc;

F2 = fftshift(fft2(double(img2)));

F2_Mag = abs(F2);

F2_Phase = exp(1i*angle(F2));

% figure; imagesc(abs(F1_Mag)); colormap(gray); title('Magnitude Motorcycle');
% figure; imagesc(abs(F1_Phase));  colormap(gray); title('Phase Motorcycle');
% figure; imagesc(abs(F2_Mag)); colormap(gray); title('Magnitude Fish');
% figure; imagesc(abs(F2_Phase));  colormap(gray); title('Phase Fish');

% Switch magnitude and phase of 2D FFTs
disp('F1_Mag *F2_Phase');
tic;
Hybrid1 = F1_Mag.*F2_Phase;
toc;
disp('F2_Mag * F1_PHase');
tic;
Hybrid2 = F2_Mag.*F1_Phase;
toc;


disp('ifft2(Hybrid1)');
tic;
Hybrid1 = ifft2(ifftshift(Hybrid1));
toc;

disp('ifft2(Hybrid2)');
tic;
Hybrid2 = ifft2(ifftshift(Hybrid2));
toc;

disp('Time to Display Image 1');
tic;
figure, imshow(Hybrid1), colormap gray, title('Hybrid 1');
toc;

disp('Time to Display Image 2');
tic;
figure, imshow(Hybrid2), colormap gray, title('Hybrid 2');
toc;

% Old method
% F1     = fftshift(fft2(double(img1)));
% magB   = log(1+abs(F2));
% phiB = angle(F2);
% F2     = fftshift(fft2(double(img2)));
% magB   = log(1+abs(F2));
% phiB = angle(F2);

% fftC = magA.*exp(phiB);
% fftD = magB.*exp(phiA);
