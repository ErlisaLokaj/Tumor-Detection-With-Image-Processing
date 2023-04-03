clear;
clc;
pkg load image
%image import
figure(1)
obj = imread('TumorData/no/no1.jpg');
imshow(obj);
%convert to grayscale
mri = rgb2gray(obj);



