clc;
clear all;
close all;
help imshow;
pkg load image;

% Part 2 : Averaging using gaussian filter
flower= imread('flower.bmp');
#lena= imread('Lena.pgm');
gray_flower=rgb2gray(flower);

gaussian = fspecial('gaussian', 3, 1); % filtre gaussien 3x3
gaussianApplyed= conv2(gray_flower, gaussian);

moveAverage = ones(3, 3)/9;
moveAverageApplyed = conv2(gray_flower, moveAverage);

figure;
subplot(1,3,1);
imshow(gray_flower, []);
title('image originale');

subplot(1,3,2);
imshow(gaussianApplyed, []);
title('image Gaussienne');

subplot(1, 3, 3);
imshow(moveAverageApplyed, []);
title('image average');

who;
whos;
