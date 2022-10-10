clear;
pkg load image;

p = imread('../Lab1/flower.bmp');
pgray = rgb2gray(p);
gauss = fspecial("gaussian", 3, 1);
[lines, column] = size(gauss);

gradVert = zeros(lines, column);
for i = 1:lines-1
    for j = 1:column
        gradVert(i, j) = gauss(i+1, j) - gauss(i, j);
    endfor
endfor
gradVertImg = conv2(pgray, gradVert);

figure(1, "name", "horrizontal gradiant");
imshow(gradVertImg, []);


gradHorr = zeros(lines, column);
for i = 1:lines
    for j = 1:column-1
        gradHorr(i, j) = gauss(i, j+1) - gauss(i, j);
    endfor
endfor
gradHorrImg = conv2(pgray, gradHorr);
figure(2, "name", "vertial gradiant");
imshow(gradHorrImg, []);