clear all;
close all;
clc;

%% initialisation des variables
%1
N1 = 256;
img = imread('cb.jpg');
image = 1/3*img(:,:,1) + 1/3*img(:,:,2) + 1/3*img(:,:,3); % binarisation de l'image
%3 
arr = 0;

%% 2 - 3 - 3 - Exctraction de la signature le long d'un rayon utile


%% 1 - Extraction d'une signature par echantillonage de l'intensité de l'image le long du rayon initial

figure;
imshow(image);

title('Selectionnez les 2 extremités du code barre');
[A,B]=ginput(2);

dist = sqrt((A(2)-A(1))^2 + (B(2)-B(1))^2); % distance entre les deux points recuperes
dist=round(dist); % arrondis a l'entier le plus proche
dx = abs(A(2)-A(1))/dist; %calcul de la distance entre les deux points en abscisses
dy = abs(B(2)-B(1))/dist; %calcul de la distance entre les deux points en ordonnees

N = floor(dist); % recuperation de la partie entiere de dist
vect = 0:1:N-1; 
M = A + vect/(N-1).*(B-A); % segment avec les points a recuperer pour la signature

A = round(A);
B = round(B);

% premiere signaturee recuperees sur le code barre binarisee prealablement
for k=0:dist-1
    signature(k+1) = image(round(B(1)+(k*dy)),round(A(1)+(k*dx)));
end
figure;
plot(signature);
title('Premiere signature recuperee sur le code barre');
%% 2 - Estimation d'un seuil de binarisation de la signature

% implementation de l'agorithme histogramme dans la fonction 'Histogram'
hist = Histogram(signature(:),N1,N);

% Representation de l'histogramme 
figure;
plot(hist);
title('Histogramme de la signature');

% determination des criteres par l'algorithme d'Otsu 

critere = Otsu(hist(:),N1);

% recuperation du seuil equivalent a l'indice du max des criteres prealablement calculees

[crit, seuil] = max(critere);


for k = 1:length(signature)
    if(signature(k)>seuil)
        signature_bin(k) = 1 ;
    else
        signature_bin(k) = 0;
    end
end

%% 3 - Determination des limites "gauche" et "droite" de la partie utile de la signature binarisée

% recuperation de l'indice de debut
for i=1:length(signature_bin)
    if signature_bin(i) ==0 && arr==0
        debut = i;
        arr = arr+1; %critere d'arret
    end
end


% recuperation de l'indice de fin
for i=1:length(signature_bin)
    if signature_bin(i) ==0
        fin = i;
    end
end

signature_f = signature_bin (debut : fin); % on recupere le debut et la fin de notre signature

%% 4 - Estimation des extrémités d'un rayon utile correspondant aux limites "gauche" et "droite"

u = floor(N/95)+1; % determination de u pour le reechantillonage de la signature 
pas=(fin-debut)/(u*95);
fin_ray_utile = 95*u;

%% 5 - Extraction d'une seconde signature par échantillonage de l'intensité de l'image le long du rayon utile



for k=1:fin_ray_utile
    code(k)=signature(round(k*pas)); %interpolation pour avoir un code en multiple de 95
end

%% 6 - Binarisation de la seconde signature


for k = 1:length(code)
    if(code(k)>seuil)
        signature_bin_2(k) = 1 ;
    else
        signature_bin_2(k) = 0;
    end
end

%representation de la bonne signature
figure;
plot(signature_bin_2)
title('Binarisation de la nouvelle signature extraite');

%% 2 - 3 - 4 - Identification des chiffres codés dans la signature

%division de la signature en section de 7*u bits en prenant soin de ne pas
%prendre les 3*u premiers bit / les 5*u bits du milieu du code barre / les
%3*u derniers bits 

sig_1 = signature_bin_2(3*u+1:3*u+7*u);
sig_2 = signature_bin_2(3*u+7*u+1:3*u+2*7*u);
sig_3 = signature_bin_2(3*u+2*7*u+1:3*u+3*7*u);
sig_4 = signature_bin_2(3*u+3*7*u+1:3*u+4*7*u);
sig_5 = signature_bin_2(3*u+4*7*u+1:3*u+5*7*u);
sig_6 = signature_bin_2(3*u+5*7*u+1:3*u+6*7*u);


sig_7 = signature_bin_2(5*u+3*u+6*7*u+1:5*u+3*u+7*7*u);
sig_8 = signature_bin_2(3*u+7*7*u+5*u+1:5*u+3*u+8*7*u);
sig_9 = signature_bin_2(5*u+3*u+8*7*u+1:5*u+3*u+9*7*u);
sig_10 = signature_bin_2(5*u+3*u+9*7*u+1:5*u+3*u+10*7*u);
sig_11 = signature_bin_2(5*u+3*u+10*7*u+1:5*u+3*u+11*7*u);
sig_12 = signature_bin_2(5*u+3*u+11*7*u+1:5*u+3*u+12*7*u);

%% 1 - Construction d'une signature theorique de longeur 7 & Dillatation de la signature théorique sth en fonction de l'unité u  


[value] = sign2num(u,sig_7);


