clc;
clear all;
close all;
help imshow;
pkg load image;

% Part 1 : Moving average and Thresholding
flower= imread('flower.bmp');
gray_flower=rgb2gray(flower);

g= ones(3,3)/9;

%h = filter2(g, gray_flower);
h= conv2(gray_flower, g);

figure;
subplot(1,2,1);
imshow(gray_flower, []);
title('image originale');

subplot(1,2,2);
imshow(h, []);
title('image filtrée');

who;
whos;
