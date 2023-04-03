clear;
clc;
pkg load image
%image import
figure(1)
obj = imread('TumorData/no/no3.jpg');
mri = rgb2gray(obj);

% Saving the size of the mri in pixels- 
% M : no of rows (height of the image) N : no of columns (width of the image) 
[M, N] = size(mri); 
  
% Getting Fourier Transform of the mri 
FT_img = fft2(double(mri)); 
  
% Assign the order value 
n = 4; 
  
% Assign Cut-off Frequency 
D0 = 3; 
  
% Designing filter 
u = 0:(M-1); 
v = 0:(N-1); 
idx = find(u > M/2); 
u(idx) = u(idx) - M; 
idy = find(v > N/2); 
v(idy) = v(idy) - N; 
  
% returns 2D grid which contains the coordinates of vectors  
% v and u. Matrix V with each row is a copy of v  
% and matrix U with each column is a copy of u  
[V, U] = meshgrid(v, u); 
  
% Calculating Euclidean Distance 
D = sqrt(U.^2 + V.^2); 
  
% determining the filtering mask 
H = 1./(1 + (D0./D).^(2*n)); 
  
% Convolution between the Fourier Transformed  
% image and the mask 
G = H.*FT_img; 
  
% Getting the resultant image by Inverse Fourier Transform   
output_image = real(ifft2(double(G)));  
    
% Displaying Input Image and Output Image  
subplot(1, 2, 1), imshow(mri),  
subplot(1, 2, 2), imshow(output_image, [ ]); title('BHPF Image');
[centersbhpf,radiibhpf, strengthsbhpf] = imfindcircles(output_image,[20,50], 'ObjectPolarity', 'bright','Sensitivity',0.9); %find bright obj in dark background. 
hbhpf = viscircles(centersbhpf,radiibhpf);


