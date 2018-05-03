clear;
clc;
close all;

load('trainedNet.mat');

mypi = raspi('192.168.110.164','pi','raspberry');
wcam = webcam(mypi);
% camList = webcamlist;
% wcam = webcam(1);
 
for i=1:10
    img = snapshot(wcam);
    
    img = rgb2gray(img);
    img = imresize(img,[160 120]);

    level = 3;
    wavelet = 'bior1.1';
    
    [c,s]=wavedec2(img,level,wavelet); 
    [H3,V3,D3] = detcoef2('all',c,s,level);
    A3 = appcoef2(c,s,wavelet,level);

    A3img = wcodemat(A3,255,'mat',1);
    H3img = wcodemat(H3,255,'mat',1);
    V3img = wcodemat(V3,255,'mat',1);
    D3img = wcodemat(D3,255,'mat',1);

    [len,width] = size(A3img);
    AnewImage = reshape(A3img, [1, (len*width)]);
    HnewImage = reshape(H3img, [1, (len*width)]);
    VnewImage = reshape(V3img, [1, (len*width)]);
    DnewImage = reshape(D3img, [1, (len*width)]);

    allImages = [AnewImage, HnewImage, VnewImage, DnewImage];


    allImages = reshape(allImages,[40,30]);
    allImages = mat2gray(allImages);
    
    imwrite(allImages,'image.jpg');
    
    imds = imageDatastore('image.jpg');
    
    YPred = classify(trainedNet,imds)   
   
    disp('Press a key to continue');
    pause;
    
    close all
    
end
