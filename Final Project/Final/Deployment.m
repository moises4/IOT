clear;
clc;
close all;

mypi = raspi('192.168.110.164','pi','raspberry');
wcam = webcam(mypi);

while (1)
    img = snapshot(wcam);
    img = rgb2gray(img);
    img = imresize(img,[320 240]);

    figure;
    imagesc(img);
    drawnow;

    [c,s]=wavedec2(img,3,'bior6.8'); 

    [H3,V3,D3] = detcoef2('all',c,s,3);
    A3 = appcoef2(c,s,'bior6.8',3);

    A3img = wcodemat(A3,255,'mat',1);
    H3img = wcodemat(H3,255,'mat',1);
    V3img = wcodemat(V3,255,'mat',1);
    D3img = wcodemat(D3,255,'mat',1);

    [len,width] = size(A3img);
    AnewImage = reshape(A3img, [1, (len*width)]);
    HnewImage = reshape(H3img, [1, (len*width)]);
    VnewImage = reshape(V3img, [1, (len*width)]);
    DnewImage = reshape(D3img, [1, (len*width)]);

    figure;
    subplot(2,2,1);
    imagesc(A3img);
    colormap pink(255);
    title('Approximation Coef. of Level 3');
    subplot(2,2,2)
    imagesc(H3img);
    title('Horizontal detail Coef. of Level 3');
    subplot(2,2,3)
    imagesc(V3img);
    title('Vertical detail Coef. of Level 3');
    subplot(2,2,4)
    imagesc(D3img);
    title('Diagonal detail Coef. of Level 3');

    % Four 54x44 wavelet images
    allImages = [AnewImage, HnewImage, VnewImage, DnewImage];

    disp('Push to NN');

    disp('Press a key to continue');
    pause;
    
end
