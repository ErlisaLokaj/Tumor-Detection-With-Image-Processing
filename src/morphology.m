clear;
clc;
pkg load image
%image import
figure(1)
obj = imread('TumorData/no/no3.jpg');
I = rgb2gray(obj);
imshow(I), title('Original Image');

%4 morphological technigues used
figure(2)
se = strel('disk',20,0);
Io = imopen(I,se);
subplot(1,2,1), imshow(Io), title('Opening');
[centerso,radiio, strengthso] = imfindcircles(Io,[20,50], 'ObjectPolarity', 'bright','Sensitivity',0.8); %find bright obj in dark background. 
ho = viscircles(centerso,radiio);

Ie = imerode(I,se);
Iobr = imreconstruct(Ie,I);
subplot(1,2,2), imshow(Iobr), title('Opening-by-Rec');
[centersor,radiior, strengthsor] = imfindcircles(Iobr,[20,50], 'ObjectPolarity', 'bright','Sensitivity',0.9); %find bright obj in dark background. 
hor = viscircles(centersor,radiior);

figure(3)
se1 = strel('disk',20,0);
Io1 = imopen(I,se1);
Ioc = imclose(Io1,se1);
subplot(1,2,1), imshow(Ioc), title('Opening-Closing');
[centersoc,radiioc, strengthsoc] = imfindcircles(Ioc,[20,50], 'ObjectPolarity', 'bright','Sensitivity',0.9); %find bright obj in dark background. 
hoc = viscircles(centersoc,radiioc);

Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobrd),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
subplot(1,2,2), imshow(Iobrcbr), title('Opening-Closing by Rec');
[centersocr,radiiocr, strengthsocr] = imfindcircles(Iobrcbr,[20,50], 'ObjectPolarity', 'bright','Sensitivity',0.9); %find bright obj in dark background. 
hocr = viscircles(centersocr,radiiocr);







