clear all;
close all;
clc;

%% initialisation des variables
%1
N1 = 256;
img = imread('code_boot.jpg');
image = 1/3*img(:,:,1) + 1/3*img(:,:,2) + 1/3*img(:,:,3); % binarisation de l'image
%3 
arr = 0;
tab = [];
%% 2 - 3 - 3 - Exctraction de la signature le long d'un rayon utile
 
%% 1 - Extraction d'une signature par echantillonage de l'intensité de l'image le long du rayon initial
figure;
imshow(img);
[ D,Txy,Ix,Iy,Wxy ] = seg_interet(image);
% binarisation
for i=1:length(D(1,:))
    for j = 1:length(D(:,1))
        if D(j,i) > 0.99  % seuil arbitraire a definir en fonction des parametre pour qu'il s'ajuste
            D1(j,i) = 0;
        else 
            D1(j,i) =1;
        end
        
    end
end

figure;
imshow(D);
title('Affichage de la mesure de cohérence D appliquee a l image');


%region probable du code barre
figure;
imshow(D1);
title('Masque de detection du code barre');
 
%% 2 - lancer aléatoire d'un rayon

%% utilisation de la méthode de detection des bordures droite et gauche et ensuite prise de la moitie du sgement 
% je vous ai écrit un pave qui explique comment j'ai raisonne pour faire la
% suite 

% probleme marche que pour des images 'clean' apres binarisation (sans point noir trop gros)
% marche que pour des codes barres horizontaux (je pense)
% principe je calcul le nb de zeros pour chaque ligne et chaque colonne et
% Je les mets dans les vecteurs COUNT_x et COUNT_y. 

% Ensuite je dis que quand ya moins de 150 zeros je considere que c'est pas
% une ligne/colonne interessante donc je mets un 0 dans le vecteur a cet
% endroit. 

% Ensuite je fais la meme chose avec un seuil superieur de 800 

% ensuite j'enleve les contours souvent noirs avec la binarisation 

% ensuite je considere que si dans COUNT_x et COUNT_y il y a moins de
% sequence de nombres d'affilee que le pas =11 alors je remplace par 0 tout ces nombres.
% c'est pour eviter de detecter des zones qui sont un peu plus petite que
% le code barre 

% et enfin j'affiche les points obtenues sur l'image 
% et ensuite je prend le milieu des deux sements verticaux et je prend la
% signature

% faudrait essayer d'autre methode genre centre de gravite 

% apres pour moi le gros soucis vient de l'image une fois binarisee avec le
% seuil (ligne 22) car c;est censé s'adapter a chaque image sinon on
% detecte mal 

% voila bon courage 
% PS : j'ai teste et ca marche que pour cette image :(
 
count_z = 0;

% calcul le nb de zeros par lignes
for nb_line = 1:length(D1(:,1))
    for nb_col = 1:length(D1(1,:))
        if D1(nb_line,nb_col) == 0 
            count_z = count_z + 1 ;
        end      
    end 
    COUNT_y(nb_line) = count_z;
    count_z = 0;
end 
% 
%calcul le nb de zeros par colonnes
for nb_col = 1:length(D1(1,:))
    for nb_line = 1:length(D1(:,1))
        if D1(nb_line,nb_col) == 0
            count_z = count_z + 1 ;
        end
    end
    COUNT_x(nb_col) = count_z;
    count_z = 0;
end


% recuperation des lignes avec le plus de zeros // 1 affinage en y
for len = 1:length(COUNT_y)    
    if COUNT_y(len) <150
        COUNT_y(len) = 0;
    elseif COUNT_y(len) >800
        COUNT_y(len) = 0;
    end
    
end

% recuperation des colonnes avec le plus de zeros // 1er affinage en x

for len = 1:length(COUNT_x)    
    if COUNT_x(len) <150
        COUNT_x(len) = 0;
    elseif COUNT_x(len) >800
        COUNT_x(len) = 0;
    end
end
      
pas = 11;
end_x = length(COUNT_x);
end_y = length(COUNT_y);

%on gere les contour
for h = end_x-100:end_x
    COUNT_x(h) = 0;
end

for h = 1:100
    COUNT_x(h) = 0;
end

for h = 1:100
    COUNT_y(h) = 0;
end

for h = end_y-100:end_y
    COUNT_y(h) = 0;
end

for len = 1 :pas: length(COUNT_x)-pas
    init_x = 0;
    for f = 0:pas-1
        if COUNT_x(len+f)==0
            init_x = init_x +1;
        end
    end
    if init_x >0
        for g = 0:pas-1
        COUNT_x(len+g) = 0;   
        end
    end
    
end


for len = 1 :pas: length(COUNT_y)-pas
    init_y = 0;
    for f = 0:pas-1
        if COUNT_y(len+f)==0
            init_y = init_y +1;
        end
    end
    if init_y >0
        for g = 0:pas-1
        COUNT_y(len+g) = 0;   
        end
    end  
end

% % affinage moins de 10 sequence d'affiler en x




% recuperation de x2
for len=1:length(COUNT_y)
    if COUNT_y(len) ~= 0
        x2 = len;
    end
end

% recuperation de x1
inity =0;
for len=1:length(COUNT_y)
    if COUNT_y(len) ~= 0 && inity == 0
        x1 = len;
        inity = 1;
    end
end

initx =0;
% recuperation de y1
for len=1:length(COUNT_x)
    if COUNT_x(len) ~= 0 && initx == 0
        y1 = len;
        initx = 1;
    end
end

% recuperation de y2
for len=1:length(COUNT_x)
    if COUNT_x(len) ~= 0
        y2 = len;
    end
end

% recuperer les points de ces differents vecteurs (indice vecteur COUNT_x,COUNT_y)

% affichage des points d'interet

imshow(D1);
axis on
hold on;
plot(y1,x1, 'r+', 'MarkerSize', 15, 'LineWidth', 2);
hold on;
plot(y1,x2, 'b+', 'MarkerSize', 15, 'LineWidth', 2);
hold on;
plot(y2,x1, 'r+', 'MarkerSize', 15, 'LineWidth', 2);
hold on;
plot(y2,x2, 'b+', 'MarkerSize', 15, 'LineWidth', 2);


% %% recuperation de la signature


xmid = (x2 + x1)/2;
ymid = (y2 + y1)/2;
hold on; 
plot(y2,xmid, 'b+', 'MarkerSize', 15, 'LineWidth', 2);
hold on;
plot(y1,xmid, 'b+', 'MarkerSize', 15, 'LineWidth', 2);
hold on;
plot(ymid,xmid, 'b+', 'MarkerSize', 15, 'LineWidth', 2);
A = [xmid;y2];
B = [xmid;y1];
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
% figure;
% plot(signature);
% title('Premiere signature recuperee sur le code barre');
%% 2 - Estimation d'un seuil de binarisation de la signature

% implementation de l'agorithme histogramme dans la fonction 'Histogram'
hist = Histogram(signature(:),N1,N);

% Representation de l'histogramme 
% figure;
% plot(hist);
% title('Histogramme de la signature');

% determination des criteres par l'algorithme d'Otsu 

critere = Otsu(hist(:),N1);

% recuperation du seuil equivalent a l'indice du max des criteres prealablement calculees

[crit, seuil] = max(critere);


for k = 1:length(signature)
    if(signature(k)>seuil-1)
        signature_bin(k) = 1 ;
    else
        signature_bin(k) = 0;
    end
end

% figure;
% plot(signature_bin);

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
 
% figure;
% plot(signature_f);


%% 4 - Estimation des extremites d'un rayon utile correspondant aux limites "gauche" et "droite"

u = floor(N/95)+1; % determination de u pour le reechantillonage de la signature 
distance = fin - debut;
pas=distance/(u*95);
fin_ray_utile =fin + distance*95*u;

%% 5 - Extraction d'une seconde signature par échantillonage de l'intensité de l'image le long du rayon utile


for k=1:u*95
    code(k)=signature(debut + round(k*pas)); %interpolation pour avoir un code en multiple de 95
end


%% 6 - Binarisation de la seconde signature


for k = 1:length(code)
    if(code(k)>seuil-1)
        signature_bin_2(k) = 1 ;
    else
        signature_bin_2(k) = 0;
    end
end

%representation de la bonne signature
% figure;
% plot(signature_bin_2)
% title('Binarisation de la nouvelle signature extraite');

%% 2 - 3 - 4 - Identification des chiffres codés dans la signature

%division de la signature en section de 7*u bits en prenant soin de ne pas
%prendre les 3*u premiers bit / les 5*u bits du milieu du code barre / les
%3*u derniers bits 


sign = decoupe(signature_bin_2,u);

%% 1 - Construction d'une signature theorique de longeur 7 & Dillatation de la signature theorique sth en fonction de l'unite u  

tab=[];
ALP =[];
for i = 1: length(sign(:,1))-1
    [value,alphabet] = sign2num(u,sign(i,:));
    tab = [tab value]; %pasbon 
    if i<7
        ALP = strcat(ALP,alphabet);
    end
end

num = first_num(ALP);
tab = [num tab];
[last_nu] = last_num (tab);
%vecteur avec toutes les valeurs decodee

tab = [tab last_nu];