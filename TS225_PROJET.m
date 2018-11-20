clear all; 
close all; 
clc; 




img = imread('image_cassegrain.jpeg');
figure;
imshow(img);

[A,B]=ginput(2);

%% on recupere la distance 

dx = abs(B(1)-A(1));  
dy = abs(B(2)-A(2));

dist = sqrt(dx^2 + dy^2); % distance entre les deux points recuperes

N = floor(dist);  

vect = 0:1:N-1;
M = A + vect/(N-1).*(B-A); % segment avec les points a recuperer pour la signature



%% Signature

image = 1/3*img(:,:,1) + 1/3*img(:,:,2) + 1/3*img(:,:,3);
imshow(image);

for i=1:length(M)
    signature(i)  = image(floor(M(1,i)),floor(M(2,i)));
end
imshow(signature);
figure;

plot(signature);
title('Signal de la signature selectionnees');


