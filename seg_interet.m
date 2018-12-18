function [ D,Txy ] = seg_interet( image )
%% help 


%% 1 -  initialisation des variables 

sigmag = 60;
M = 60;
x = -M:M;

sigmag2 = 1; % parametre
sigmat2 = 500 ; % taille de l'image
% image = I/255;

%% 2 - fonction de ponderation du voisinage 

[ Wxy ] = passebas(sigmat2);
    
%% 3 - dérivée horizontale et verticale du gaussienne

% filtre de canny

[Iy,Ix] = canny(sigmag2,image);
 

%% 4 - calcul des tenseurs  


T_xx = conv2(Ix.*Ix,Wxy,'same'); % fltre convolutif  avec image
T_yy = conv2(Iy.*Iy,Wxy,'same'); % fltre convolutif  avec image
T_xy = conv2(Ix.*Iy,Wxy,'same'); % fltre convolutif  avec image


%% 5 - mesure de D - très ordonnée tend vers 0, très desordonnée tend vers 1

Txy = [T_xx,T_xy ; T_xy , T_yy];

D = sqrt((T_xx-T_yy).^2+4*(T_xy).^2)/(T_xx+T_yy);


end

