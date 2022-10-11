clear;
imageBuss = imread('bus.jpeg');
imageSimpson = imread('simpsons.jpeg');

busDisplayCorners  = [583 209; 798 229; 594 520; 807 468];
simpsonCorners = [1 1; 1000 1; 1 1500; 1000 1500];
#(TL TR BL BR) where desided by zooming in to see the actual pixel and selecting the corners looking hte more like the corners of the display.
TopAfine_A = (busDisplayCorners(2, 2) - busDisplayCorners(1, 2))/(busDisplayCorners(2, 1)-busDisplayCorners(1,1));
TopAfine_B = busDisplayCorners(1, 2) - TopAfine_A*busDisplayCorners(1, 1);
busCpy = imageBuss;
EquMat = [
          simpsonCorners(1, 1) simpsonCorners(1, 2) 1 0 0 0 -(simpsonCorners(1, 1) * busDisplayCorners(1, 1)) -(simpsonCorners(1, 2) * busDisplayCorners(1, 1));
          0 0 0 simpsonCorners(1, 1) simpsonCorners(1, 2) 1 -simpsonCorners(1, 1)*busDisplayCorners(1, 2) -(simpsonCorners(1, 2) * busDisplayCorners(1, 2));
          simpsonCorners(2, 1) simpsonCorners(2, 2) 1 0 0 0 -(simpsonCorners(2, 1) * busDisplayCorners(2, 1)) -(simpsonCorners(2, 2) * busDisplayCorners(2, 1));
          0 0 0 simpsonCorners(2, 1) simpsonCorners(2, 2) 1 -simpsonCorners(2, 1)*busDisplayCorners(2, 2) -(simpsonCorners(2, 2) * busDisplayCorners(2, 2));
          simpsonCorners(3, 1) simpsonCorners(3, 2) 1 0 0 0 -(simpsonCorners(3, 1) * busDisplayCorners(3, 1)) -(simpsonCorners(3, 2) * busDisplayCorners(3, 1));
          0 0 0 simpsonCorners(3, 1) simpsonCorners(3, 2) 1 -simpsonCorners(3, 1)*busDisplayCorners(3, 2) -(simpsonCorners(3, 2) * busDisplayCorners(3, 2));
          simpsonCorners(4, 1) simpsonCorners(4, 2) 1 0 0 0 -(simpsonCorners(4, 1) * busDisplayCorners(4, 1)) -(simpsonCorners(4, 2) * busDisplayCorners(4, 1));
          0 0 0 simpsonCorners(4, 1) simpsonCorners(4, 2) 1 -simpsonCorners(4, 1)*busDisplayCorners(4, 2) -(simpsonCorners(4, 2) * busDisplayCorners(4, 2));
        ];
BusAsCol = [
        busDisplayCorners(1, 1);
        busDisplayCorners(1, 2);
        busDisplayCorners(2, 1);
        busDisplayCorners(2, 2);
        busDisplayCorners(3, 1);
        busDisplayCorners(3, 2);
        busDisplayCorners(4, 1);
        busDisplayCorners(4, 2);
    ];
a = EquMat\BusAsCol;
T = [
    a(1) a(2) a(3);
    a(4) a(5) a(6);
    a(7) a(8) 1;
]

figure("name", "test transform B->S");
TL = pinv(T) * [busDisplayCorners(1, 1); busDisplayCorners(1, 2); 1];
TR = pinv(T) * [busDisplayCorners(2, 1); busDisplayCorners(2, 2); 1];
BL = pinv(T) * [busDisplayCorners(3, 1); busDisplayCorners(3, 2); 1];
BR = pinv(T) * [busDisplayCorners(4, 1); busDisplayCorners(4, 2); 1];
TL = [TL(1) / TL(3);TL(2)/TL(3); 1];
TR = [TR(1) / TR(3);TR(2)/TR(3); 1];
BR = [BR(1) / BR(3);BR(2)/BR(3); 1];
BL = [BL(1) / BL(3);BL(2)/BL(3); 1];
hold("on");
imshow(imageSimpson, []);
plot(TL(1), TL(2), "ro");
plot(TR(1), TR(2), "ro");
plot(BL(1), BL(2), "ro");
plot(BR(1), BR(2), "ro");
hold("off");