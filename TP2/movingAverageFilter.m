clear;

p = imread('../Lab1/flower.bmp');
pgray = rgb2gray(p);

figure(1);
imshow(pgray);

#f = 1/9 * ones(3, 3);
f = fspecial("average", 3);
res = filter2(f, pgray);
figure(2);
imshow(res,[]);
whos;