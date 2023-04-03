clear;
clc;
pkg load image
%image import
figure(1)
obj = imread('TumorData/no/no3.jpg');

%convert to grayscale
mri = rgb2gray(obj);
subplot(1,2,1), imshow(mri); title('Original Image');

%median filter
MFOutput = medfilt2(mri);
subplot(1,2,2), imshow(MFOutput); title('Median filter output');
[centersmf,radiimf, strengthsmf] = imfindcircles(MFOutput,[20,50], 'ObjectPolarity', 'bright','Sensitivity',0.925); %find bright obj in dark background. 
hmf = viscircles(centersmf,radiimf);