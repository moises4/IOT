% Me lol

clear;
clc;
close all; % closes all figures

Irisdata = IrisImport('Iris.csv', 2, 151);
Irisdata = table2array(Irisdata);

Id = Irisdata(:,1);
sepalLen = Irisdata(:,2);
sepalWid = Irisdata(:,3);
petalLen = Irisdata(:,4);
petalWid = Irisdata(:,5);
Species = Irisdata(:,6);


for i = 1:150
    Id1(i,1) = str2double(Id(i));
    sepalLen1(i,1) = str2double(sepalLen(i));
    sepalWid1(i,1) = str2double(sepalWid(i));
    petalLen1(i,1) = str2double(petalLen(i));
    petalWid1(i,1) = str2double(petalWid(i));
    
end

data = [Id1 sepalLen1 sepalWid1 petalLen1 petalWid1];

figure;
scatter(data(:,5), data(:,2), data(:,3), data(:,4));
k = 5;

[cidx,C,sumd,D] = kmeans(data, k);
[s,h] = silhouette(data,cidx);
