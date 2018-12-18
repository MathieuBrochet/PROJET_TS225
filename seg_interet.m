function [ D,Txy ] = seg_interet( image )
%% help 


%% 1 -  initialisation des variables 

sigmag = 60;
M = 60;
x = -M:M;
[X,Y] = meshgrid(x);
% image = I/255;
tresh = [0.10 0.50]; % pas sur 

%% 2 - fonction de ponderation du voisinage 

sigmat2 = 2.5; % parametre
Wxy = (1/(2*pi*sigmat2)).*exp(-(X.^2+Y.^2)/(2*sigmat2));


% figure, imshow(image);
% title('image ');

%% 3 - dérivée horizontale et verticale du gaussienne

sigmag2 = 10; % parametre
% filtre de canny
deriv_xy = -(X/(2*pi*sigmag2^2)).*exp(-(X.^2+Y.^2)/(2*sigmag2))-(Y/(2*pi*sigmag2^2)).*exp(-(X.^2+Y.^2)/(2*sigmag2));
deriv_yy = -2*(Y/(2*pi*sigmag2^2)).*exp(-(X.^2+Y.^2)/(2*sigmag2));
deriv_xx = -2*(X/(2*pi*sigmag2^2)).*exp(-(X.^2+Y.^2)/(2*sigmag2));


%% 4 - calcul des tenseurs  

Ixx = conv2(deriv_xx,image,'same'); % filtre canny convolutif
Iyy = conv2(deriv_yy,image,'same');
Ixy = conv2(deriv_xy,image,'same');

T_xx = conv2(Wxy,Ixx,'same'); % fltre convolutif  avec image
T_yy = conv2(Wxy,Iyy,'same'); % fltre convolutif  avec image
T_xy = conv2(Wxy,Ixy,'same'); % fltre convolutif  avec image
%% 5 - mesure de D - très ordonnée tend vers 0, très desordonnée tend vers 1

Txy = [T_xx,T_xy ; T_xy , T_yy];

% [lamb1, lamb2] = eig(Txy);
% 
% Dxy = (lamb1 - lamb2)/ (lamb1 + lamb2);
D = sqrt((T_xx-T_yy).^2+4*(T_xy).^2)/(T_xx+T_yy);


end

