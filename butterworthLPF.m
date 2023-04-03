clear;
clc;
pkg load image
%image import
figure(1)
obj = imread('TumorData/no/no1.jpg');
mri = rgb2gray(obj);

% Saving the size of the mri in pixels- 
% M : no of rows (height of the image) N : no of columns (width of the image) 
[M, N] = size(mri); 
  
% Getting Fourier Transform of the mri 
FT_img = fft2(double(mri));

% assign order
n1 = 2; 
  
% Assign Cut-off Frequency 
D0a = 20; 
  
% Designing filter 
u1 = 0:(M-1); 
v1 = 0:(N-1); 
idx = find(u1 > M/2); 
u1(idx) = u1(idx) - M; 
idy = find(v1 > N/2); 
v1(idy) = v1(idy) - N; 
  
% meshgrid(v, u) returns 2D grid which contains the coordinates of vectors  
% v and u. Matrix V with each row is a copy of v  
% and matrix U with each column is a copy of u  
[V1, U1] = meshgrid(v1, u1); 
  
% Calculating Euclidean Distance 
Da = sqrt(U1.^2 + V1.^2); 
  
% determining the filtering mask 
Ha = 1./(1 + (Da./D0a).^(2*n1)); 
  
% Convolution between the Fourier Transformed  
% image and the mask 
Ga = Ha.*FT_img; 
  
% Getting the resultant image by Inverse Fourier Transform   
output_image1 = real(ifft2(double(Ga)));  
    
% Displaying Input Image and Output Image  
subplot(1, 2, 1), imshow(mri),  
subplot(1, 2, 2), imshow(output_image1, [ ]);
[centersblpf,radiiblpf, strengthsblpf] = imfindcircles(output_image1,[20,50], 'ObjectPolarity', 'bright','Sensitivity',0.7); %find bright obj in dark background. 
hblpf = viscircles(centersblpf,radiiblpf);