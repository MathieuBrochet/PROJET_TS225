clear all; 
close all;
clc;


%% 

img1 = imread('cameraman.png');
grey = rgb2gray(img1);
S = surf(grey);
title('Visualisation relief 3D en niveau de gris de cameraman ')
shading interp;


%% 

% la fonction gradient retourne le gradient selon les composantes
% horizontales et verticales à l'aide des dérivées selon X et Y

 
%% 

[GradX GradY]= gradient(double(grey));

Norm = sqrt(GradX.^2 + GradY.^2  ); 
figure;
img_f = uint8(Norm);
imshow(img_f); %affichage de la norme , visualisation de contour 
title('Representation des contours sans le seuil optimal de la Norme de cameraman');

%%

% seuil = 30 

img_f1 = (img_f(:,:) > 45);
figure;

imshow(img_f1);
title('Representation des contours avec le seuil optimal de la Norme de cameraman');




%% 
sigma = 8;   
[X, Y] = meshgrid(floor(-3*sigma):floor(3*sigma), floor(-3*sigma):floor(3*sigma));
g1 = (1/(2*pi*sigma^2)*exp((-X.^2-Y.^2)/(2*sigma^2))); 


%% Effet Pencil Sketch

% application du filtre de Sobbel
 home1 = imread('home.jpg');
 figure;
 imshow(home1);
 home = rgb2gray(home1);
 figure;
 imshow(home);

Sx = 1/8*[1 0 -1;
    2 0 -2;
    1 0 -1];


Sy = 1/8*[1 2 1;
    0 0 0;
    -1 -2 -1];

home_x = conv2(home,Sx,'same');

home_y = conv2(home,Sy,'same');

HOME = sqrt(home_x.^2 + home_y.^2);


HOME_F = (HOME >10); 

figure;  
imshow(HOME_F);
title('Detection de contours de l image home avec Sobbel');




%%


HOME = uint8(HOME_F);
for i =1:768
    for j =1: 1024
        if HOME(i,j) == 0
            HOME_(i,j,:) = [255,255,255];
        else 
            HOME_(i,j,:) = home1(i,j,:);
        end  
    end 
end 

figure;
imshow(uint8(HOME_)); 
title('Detection de contours de l image home en couleur');



%% 

R = home1(:,:,1);
G = home1(:,:,2);
B = home1(:,:,3);
Y1 = 0.299*R + 0.587*G + 0.114*B ;
Cb = 0.564*(B-Y1) + 128;
Cr = 0.713*(R-Y1) + 128;
figure;
imshow(Y1);
title('conversion de l image Irgb en IyCbCr');
alpha = 1;
beta = 0;
Y1 = (255 - alpha)*HOME + beta; 







