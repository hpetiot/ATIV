clear;
pkg load image;
p = imread('../Lab1/flower.bmp');
pgray = rgb2gray(p);

figure(1, "name", "original");
imshow(pgray);

#f = 1/9 * ones(3, 3);
f = fspecial("average", 3);
res = filter2(f, pgray);
figure(2, "name", "moving average");
imshow(res,[]);

f = fspecial("gaussian", 3);
res = filter2(f, pgray);
figure(3, "name", "gaussian");
imshow(res, []);
whos;