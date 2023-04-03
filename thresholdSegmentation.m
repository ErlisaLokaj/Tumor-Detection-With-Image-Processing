clear;
clc;
pkg load image
%image import
figure(1)
obj = imread('TumorData/no/no2.jpg');
mri = rgb2gray(obj);
mri;
subplot(2,2,1); imshow(mri); title('Original image');

%fill holes
thresholdValue = 100;
binaryImage = mri > thresholdValue; % Bright objects will be chosen if you use >.
binaryImage = imfill(binaryImage, 'holes');
subplot(2,2,2); imshow(binaryImage); title('Holes filled');

%enhance object edge
clear = imclearborder(binaryImage);
subplot(2,2,3); imshow(clear); title('Border enhanced');

%remove noise smaller than a certain size
se = strel('disk', 16,0);
open = imopen(binaryImage,se);
subplot(2,2,4); imshow(open); title('Noise removed');

%find possible diameterFromImage
[centers,radii, strengths] = imfindcircles(open,[20,50], 'ObjectPolarity', 'bright','Sensitivity',0.9) %find bright obj in dark background. 
h = viscircles(centers,radii);