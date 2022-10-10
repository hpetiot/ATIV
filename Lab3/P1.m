clear;
imageBuss = imread('bus.jpeg');
imageSimpson = imread('simpsons.jpeg');

busDisplayCorners  = [583 209; 798 229; 594 520; 807 468];
simpsonCorners = [1 1; 1 1000; 1500 1; 1500 1000];
#(TL TR BL BR) where desided by zooming in to see the actual pixel and selecting the corners looking hte more like the corners of the display.
TopAfine_A = (busDisplayCorners(2, 2) - busDisplayCorners(1, 2))/(busDisplayCorners(2, 1)-busDisplayCorners(1,1));
TopAfine_B = busDisplayCorners(1, 2) - TopAfine_A*busDisplayCorners(1, 1);
busCpy = imageBuss;
EquMat = [
          simpsonCorners(1, 1) simpsonCorners(1, 2) 1 0 0 0 -(simpsonCorners(1, 1) * busDisplayCorners(1, 1)) -(simpsonCorners(1, 2) * busDisplayCorners(1, 1));
          0 0 0 simpsonCorners(1, 1) simpsonCorners(1, 2) 1 -simpsonCorners(1, 1)*busDisplayCorners(1, 2) -(simpsonCorners(1, 2) * busDisplayCorners(1, 2));
          simpsonCorners(2, 1) simpsonCorners(2, 2) 1 0 0 0 -(simpsonCorners(1, 1) * busDisplayCorners(2, 1)) -(simpsonCorners(2, 2) * busDisplayCorners(2, 1));
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
];

for i=simpsonCorners(1, 1):simpsonCorners(2, 1)
    for j = simpsonCorners(1, 2):simpsonCorners(3, 2)
        coordSimp = [i; j; 1];
        transCoordSimpson = T*coordSimp;
        busCpy(ceil(coordBus(1)), ceil(coordBus(2)), 1) = imageSimpson(i, j, 1);
        busCpy(ceil(coordBus(1)), ceil(coordBus(2)), 2) = imageSimpson(i, j, 2);
        busCpy(ceil(coordBus(1)), ceil(coordBus(2)), 3) = imageSimpson(i, j, 3);

    endfor
endfor
imshow(busCpy, []);
whos;