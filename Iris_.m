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
Species  = Irisdata(:,6);


for i = 1:150
    Id1(i,1) = str2double(Id(i));
    sepalLen1(i,1) = str2double(sepalLen(i));
    sepalWid1(i,1) = str2double(sepalWid(i));
    petalLen1(i,1) = str2double(petalLen(i));
    petalWid1(i,1) = str2double(petalWid(i));
    
end

data = [sepalLen1 sepalWid1 petalLen1 petalWid1];

figure;
scatter(data(:,1), data(:,2), data(:,3), data(:,4));
k = 3;


[cidx,C,sumd,D] = kmeans(data, k);
[s,h] = silhouette(data,cidx);
Species1 = 0;
Species2 = 0;
Species3 = 0;
for i = 1 : 150
    if round(cidx(i)) == 1
        Species1 = Species1 +1;
    end
    if round(cidx(i)) == 2
        Species2 = Species2 +1;
    end
    if round(cidx(i)) == 3
        Species3 = Species3 +1;
    end
end

Error1 = abs(Species1-50)/50;

Error2 = abs(Species2-50)/50;
Error3 = abs(Species3-50)/50;

TotalError = (Error1 + Error2 + Error3)/3;

TotalAccuracy = 1-TotalError;
