clc;
clear all;
close all;
help imshow;
pkg load image;
pkg load signal;
%df / dx = f(x+1) - f(x) essayer de le faire regarder de gauche à droite
flower= imread('flower.bmp');
gray_flower=rgb2gray(flower);

% Part 4 : C&C

% Gaussian filter
%gaussian= imsmooth(gray_flower, "Gaussian", 0.75);
gaussian = fspecial('gaussian', 3, 1); % filtre gaussien 3x3
gaussian_corr = fspecial('gaussian', 300, 1); % filtre gaussien 3x3
[l, c] = size(gaussian);

%[l, c] = size(gray_flower);


for i = 1:l-1
  for j = 1:c
    dfx(i, j)= gaussian(i+1, j) - gaussian(i, j);
  endfor
endfor

#{
figure;
imshow(dfx, []);
title('X');
#}

for k = 1:l
  for l = 1:c-1
    dfy(k, l)= gaussian(k, l+1) - gaussian(k, l);
  endfor
endfor

#{
figure;
imshow(dfy, []);
title('Y');
#}

grad= gradient(gray_flower);

dfN = conv2(dfx,dfy);

% img_gray convoluer au gradient de l'image en gris
% Commutativity
hX= conv2(gray_flower, dfx);
hX2= conv2(dfx, gray_flower);

% Associativity
h1 = conv2(gray_flower, dfx);
h2 = conv2(dfx, dfy);
asso= conv2(gray_flower, h2);
asso2= conv2(h1, dfy);

% Linearity
lX= conv2(0.5*gray_flower, dfx);
lX2= conv2(gray_flower, 0.5*dfx);
lX3= 0.5*conv2(gray_flower, dfx);

% Shift Invariance
im= zeros(300,300);
im(15:300, 15:300)=gray_flower(15:300, 15:300);
him= conv2(im, dfx);

im2= zeros(300,300);
him2= conv2(gray_flower, dfx);
im2(15:300, 15:300)=him2(15:300,15:300);

% Distributivity
#{
dxy = dfx + dfy;
dX2= conv2(gray_flower, dfx) + conv2(gray_flower, dfy);
dX= conv2(gray_flower, dxy);
#}

mat= ones(5,5);
mat2= ones(5,5)*5;
g= ones(3,3)*3;

dmat=mat+mat2;
dmat1=conv2(dmat, g);

dmatC1=conv2(mat, g);
dmatC2=conv2(mat2, g);
dmat2=dmatC1 + dmatC2;


hY= conv2(gray_flower, dfy);

% Cross-Correlation
#{
White = max(max(gray_flower));

imagesc(gray_flower)
axis image off
colormap gray
title('Original')

x = 60;
X = 150;
szx = x:X;

y = 60;
Y = 150;
szy = y:Y;

Sect = gray_flower(szx,szy);

kimg = gray_flower;
kimg(szx,szy) = White;

kumg = White*ones(size(gray_flower));
kumg(szx,szy) = Sect;

figure;
subplot(1,2,1)
imagesc(kimg)
axis image off
colormap gray
title('Image')

subplot(1,2,2)
imagesc(kumg)
axis image off
colormap gray
title('Section')

nimg = gray_flower-mean(mean(gray_flower));
nSec = nimg(szx,szy);

crr = xcorr2(nimg,nSec);

[ssr,snd] = max(crr(:));
[ij,ji] = ind2sub(size(crr),snd);

figure
plot(crr(:))
title('Cross-Correlation')
hold on
plot(snd,ssr,'or')
hold off
text(snd*1.05,ssr,'Maximum')

gray_flower(ij:-1:ij-size(Sect,1)+1,ji:-1:ji-size(Sect,2)+1) = rot90(Sect,2);

figure
imagesc(gray_flower)
axis image off
colormap gray
title('Reconstructed')
hold on
plot([y y Y Y y],[x X X x x],'r')
hold off
#}

% Associativity
hc1 = xcorr2(gray_flower, dfx);
hc2 = xcorr2(dfx, dfy);
assoc= xcorr2(gray_flower, h2);
assoc2= xcorr2(h1, dfy);

%Commutativity
com= xcorr2(gray_flower, gaussian_corr);
com2= xcorr2(gaussian_corr, gray_flower);

% Shift Invariance
im= zeros(300,300);
im(100:300, 100:300)=gray_flower(100:300, 100:300);
himcorr= xcorr2(im, dfx);

imcorr2= zeros(300,300);
himcorr2= xcorr2(gray_flower, dfx);
imcorr2(100:300, 100:300)=himcorr2(100:300, 100:300);

% Distributivity Correlation
m= ones(5,5);
m2= ones(5,5)*5;
g= ones(3,3)*3;

dm=m+m2;
dm1=xcorr2(dm, g);

dmC1=xcorr2(m, g);
dmC2=xcorr2(m2, g);
dm2=dmC1 + dmC2;

% Linearity
lXC= xcorr2(0.5*gray_flower, dfx);
lXC2= xcorr2(gray_flower, 0.5*dfx);
lXC3= 0.5*xcorr2(gray_flower, dfx);

% Affichage
#{
figure;
subplot(1,2,1);
imshow(hX, []);
title('Convolution to x image');

subplot(1,2,2);
imshow(hY, []);
title('Convolution to y image');

figure("name",'Commutatif');
subplot(1,2,1);
imshow(hX, []);

subplot(1,2,2);
imshow(hX2, []);

figure("name",'Linearity');
subplot(1,3,1);
imshow(lX, []);

subplot(1,3,2);
imshow(lX2, []);

subplot(1,3,3);
imshow(lX3, []);
#}
figure("name",'Associativity');
subplot(1,2,1);
imshow(asso, []);

subplot(1,2,2);
imshow(asso2, []);

figure("name",'Shift Invariance');
subplot(1,2,1);
imshow(him, []);

subplot(1,2,2);
imshow(im2, []);


figure("name",'Distributivity');
subplot(1,3,1);
imshow(dmat1, []);

subplot(1,3,2);
imshow(dmat2, []);

subplot(1,3,3);
imshow((dmat1(1:1:end, 1:1:end)-dmat2(1:1:end, 1:1:end)), []);
#}


figure("name",'Commutativity Corr');
subplot(1,2,1);
imshow(com, []);

subplot(1,2,2);
imshow(com2, []);

figure("name",'Associativity Corr');
subplot(1,2,1);
imshow(assoc, []);

subplot(1,2,2);
imshow(assoc2, []);

figure("name",'Shift Invariance Corr');
subplot(1,2,1);
imshow(himcorr, []);

subplot(1,2,2);
imshow(imcorr2, []);

figure("name",'Linearity Corr');
subplot(1,3,1);
imshow(lXC, []);

subplot(1,3,2);
imshow(lXC2, []);

subplot(1,3,3);
imshow(lXC3, []);

figure("name",'Distributivity Corr');
subplot(1,3,1);
imshow(dm1, []);

subplot(1,3,2);
imshow(dm2, []);

subplot(1,3,3);
imshow((dm1(1:1:end, 1:1:end)-dm2(1:1:end, 1:1:end)), []);

#{
figure;
imshow(dfN, []);
title('Gradient');
#}

whos;
