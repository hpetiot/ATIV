clc;
clear all;
close all;
help imshow;
pkg load image;
%df / dx = f(x+1) - f(x) essayer de le faire regarder de gauche à droite
flower= imread('flower.bmp');
gray_flower=rgb2gray(flower);

% Part 3  : Finite differences as filters
%[l, c] = size(gray_flower);

% Gaussian filter
%gaussian= imsmooth(gray_flower, "Gaussian", 0.75);
gaussian = fspecial('gaussian', 3, 1); % filtre gaussien 3x3
[l, c] = size(gaussian);

for i = 1:l-1
  for j = 1:c
    dfx(i, j)= gaussian(i+1, j) - gaussian(i, j);
  endfor
endfor

#{gaus
  figure;
  imshow(dfx, []);
  title('X');
#}

for i = 1:l
  for j = 1:c-1
    dfy(i, j)= gaussian(i, j+1) - gaussian(i, j);
  endfor
endfor

#{
  figure;
  imshow(dfy, []);
  title('Y');
#}

grad= gradient(gray_flower);

#dfN = conv2(dfx,dfy);

% img_gray convoluer au gradient de l'image en gris
hX= conv2(gray_flower, dfx);
hY= conv2(gray_flower, dfy);

#{
  figure;
  subplot(1,2,1);
  imshow(gray_flower, []);
  title('Original image');

  subplot(1,2,2);
  imshow(gaussian, []);
  title('Gaussian image');
#}

#{
  figure;
  subplot(1,2,1);
  imshow(dfx, []);
  title('Finite x differences image');


  subplot(1,2,2);
  imshow(dfy, []);
  title('Finite y differences image');
#}

#{
  figure;
  %subplot(1,3,3);
  imshow(grad, []);
  title('Gradient image');
#}

figure;
subplot(1,2,1);
imshow(hX, []);
title('Convolution with gaussiant X gradiant');

subplot(1,2,2);
imshow(hY, []);
title('Convolution with gaussiant Y gradiant');


#figure;
#imshow(dfN, []);
#title('Gradient');

whos;
