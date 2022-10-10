clc;
clear all;
close all;
help imshow;
pkg load image;
pkg load signal;

%2D
flower= imread('flower.bmp');
gray_flower=rgb2gray(flower);

[l, c] = size(gray_flower);

%Thresholding
#{
for i = 1:l-1
  for j = 1:c
    if(gray_flower(i,j) > 100)
      gray_flower(i,j)=255;
    else
      gray_flower(i,j) = 0;
    endif
  endfor
endfor
#}
% Compression sur 85
compression_rate= 75;

gaussian= imsmooth(gray_flower, "Gaussian", 0.75);

grad= gradient(gray_flower);

[U, S, V]=svd(gray_flower);

U2 = U(1:end, 1:compression_rate);
S2 = S(1:compression_rate, 1:end);

im_compressed=uint8(U2*S2*V');

%imgEdge = edge(gray_flower, 'Canny', 1/300, 5);
imgEdge = edge(gray_flower, 'Canny');
imgEdgeCompressed = edge(im_compressed, 'Canny');

figure;
subplot(2,2,1);
imshow(gray_flower, []);
title('image original');
subplot(2,2,2);
imshow(im_compressed, []);
title('image compressed');

subplot(2,2,3);
imshow(imgEdge, []);
title('Canny edge original image');
subplot(2,2,4);
imshow(imgEdgeCompressed, []);
title('Canny edge compressed');

whos;
