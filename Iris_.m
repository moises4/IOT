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
sepalLenSum = 0;
sepalWidSum = 0;
petalLenSum = 0;
petalWidSum = 0;
 
for i = 1:150
    Id1(i,1) = str2double(Id(i));
    sepalLen1(i,1) = str2double(sepalLen(i));
    sepalWid1(i,1) = str2double(sepalWid(i));
    petalLen1(i,1) = str2double(petalLen(i));
    petalWid1(i,1) = str2double(petalWid(i));
    
    sepalLenSum = sepalLenSum + sepalLen1(i,1);
    sepalWidSum = sepalWidSum + sepalWid1(i,1);
    petalLenSum = petalLenSum + petalLen1(i,1);
    ptealWidSum = petalWidSum + petalWid1(i,1);
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

%%
newsepalLen = (sepalLen1 - mean(sepalLen1)) / std(sepalLen1);
newsepalWid = (sepalWid1 - mean(sepalWid1)) / std(sepalWid1);
newPetalLen = (petalLen1 - mean(petalLen1)) / std(petalLen1);
newpetalWid = (petalWid1 - mean(petalWid1)) / std(petalWid1);

normals = [newsepalLen newsepalWid newPetalLen newpetalWid];




scatter(normals(:,1), normals(:,2), normals(:,3), normals(:,4));
k = 3;


[cidx,C,sumd,D] = kmeans(normals, k);
[s,h] = silhouette(normals,cidx);
NSpecies1 = 0;
NSpecies2 = 0;
NSpecies3 = 0;
for i = 1 : 150
    if round(cidx(i)) == 1
        NSpecies1 = NSpecies1 +1;
    end
    if round(cidx(i)) == 2
        NSpecies2 = NSpecies2 +1;
    end
    if round(cidx(i)) == 3
        NSpecies3 = NSpecies3 +1;
    end
end

NError1 = abs(NSpecies1-50)/50;

NError2 = abs(NSpecies2-50)/50;
NError3 = abs(NSpecies3-50)/50;

NormalError = (NError1 + NError2 + NError3)/3;

NormalAccuracy = 1-NormalError;


figure;
histogram(sepalLen1,35);
title('sepalLen1');


figure; 
histogram(newsepalLen,35);
title('normalizedSepal');
        
