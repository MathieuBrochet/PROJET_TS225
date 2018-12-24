clear all;
close all;
clc;
%% 3.4 Approche automatique 


N1 = 256;
img = imread('code_boot.jpg');
image = 1/3*img(:,:,1) + 1/3*img(:,:,2) + 1/3*img(:,:,3); % binarisation de l'image
% %3 
arr = 0;
% %
tab = [];
% %% 2 - 3 - 3 - Exctraction de la signature le long d'un rayon utile
% 
% %% 1 - Extraction d'une signature par echantillonage de l'intensité de l'image le long du rayon initial
% % 
figure;
imshow(img);

%% 1 - segmentation en régions d'interet  

[ D,Txy,Ix,Iy,Wxy ] = seg_interet(image(:,:));

% binarisation
for i=1:length(D(1,:))
    for j = 1:length(D(:,1))
        if D(j,i) > 0.99  % seuil arbitraire
            D1(j,i) = 0;
        else 
            D1(j,i) =1;
        end
        
    end
end


% figure;
% imshow(D);


%region probable du code barre
figure;
imshow(D1);
title('Masque de detection du code barre');


%% 2 - lancer aléatoire d'un rayon

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
    if COUNT_y(len) <100
        COUNT_y(len) = 0;
    end
    
end

% recuperation des colonnes avec le plus de zeros // 1er affinage en x

for len = 1:length(COUNT_x)    
    if COUNT_x(len) <100
        COUNT_x(len) = 0;
    end
end


% affinage moins de 10 sequence d'affiler en y
for  len = 1:10:length(COUNT_y)-9
    if COUNT_y(len) ~=0 && COUNT_y(len+1) ~=0 && COUNT_y(len+2) ~=0 && COUNT_y(len+3) ~=0 && COUNT_y(len+4) && COUNT_y(len+5) && COUNT_y(len+6) && COUNT_y(len+7) && COUNT_y(len+8) && COUNT_y(len+9)
        % on laisse 
    else 
        COUNT_y(len) = 0;
        COUNT_y(len+1) = 0;
        COUNT_y(len+2) =0;
        COUNT_y(len+3)=0;
        COUNT_y(len+4)=0;
        COUNT_y(len+5)=0;
        COUNT_y(len+6)=0;
        COUNT_y(len+7)=0;
        COUNT_y(len+8)=0;
        COUNT_y(len+9)=0;
    end
end


% affinage moins de 10 sequence d'affiler en x

for  len = 1:10:length(COUNT_x)-9
    if COUNT_x(len) ~=0 && COUNT_x(len+1) ~=0 && COUNT_x(len+2) ~=0 && COUNT_x(len+3) ~=0 && COUNT_x(len+4) && COUNT_x(len+5) && COUNT_x(len+6) && COUNT_x(len+7) && COUNT_x(len+8) && COUNT_x(len+9)
        % on laisse 
    else 
        COUNT_x(len) = 0;
        COUNT_x(len+1) = 0;
        COUNT_x(len+2) =0;
        COUNT_x(len+3)=0;
        COUNT_x(len+4)=0;
        COUNT_x(len+5)=0;
        COUNT_x(len+6)=0;
        COUNT_x(len+7)=0;
        COUNT_x(len+8)=0;
        COUNT_x(len+9)=0;
    end
end


index_x = 0;
% recuperation de x2
for len=1:length(COUNT_y)
    if COUNT_y(len) ~= 0
        x2 = len;
    end
end

% recuperation de x1
init =0;
for len=1:length(COUNT_y)
    if COUNT_y(len) ~= 0 && init == 0
        x1 = len;
        init = 1;
    end
end

init =0;
% recuperation de y1
for len=1:length(COUNT_x)
    if COUNT_x(len) ~= 0 && init == 0
        y1 = len;
        init = 1;
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