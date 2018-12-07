clear all;
close all;
clc;




img = imread('cb.jpg');
figure;
imshow(img);

[A,B]=ginput(2);

%% on recupere la distance
N1 = 256;
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
% imshow(signature);
% figure;


% plot(signature);
% title('Signal de la signature selectionnees');

%% seuil

hist = zeros(1,N1);
for i = 1 : N1
    for k = 1:N
        if (signature(k) == i)
            hist(i) = hist(i) +  1;
        end
    end
end


% figure;
% plot(hist);
% title('Histogramme de la signature');


crit = zeros(1,N1);
w_num = zeros(1,N1);
mu_num = zeros(1,N1);
w_den = sum(hist);
W = 0;
for k =1 : N1
    for i =1 : k
        w_num(k) = w_num(k) + hist(i) ;
        mu_num(k) = mu_num(k) + i*hist(i);
    end
    W(k) = w_num(k)/w_den;
    MU(k) = mu_num(k)/ w_den;
end


for k=1:N1
    crit(k) = W(k).*(MU(N1-1)-MU(k)).^2 + (1-W(k)).*(MU(k).^2);
end

[critere, max ]  = max(crit);


seuil = max;

for k = 1:length(signature)
    if(signature(k)>seuil)
        signature_bin(k) = 1 ;
    else
        signature_bin(k) = 0;
    end
end



%
%
% figure;
% subplot(2,1,1);
% plot(signature_bin);
% subplot(2,1,2);
% imshow(img);
% title('Comparaison ');


%% determination du debut du code barre

% recuperation de l'indice de debut
k = 0;
for i=1:length(signature_bin)
    if signature_bin(i) ==0 && k==0
        debut = i;
        k = k+1;
    end
end


% recuperation de l'indice de fin
for i=1:length(signature_bin)
    if signature_bin(i) ==0
        fin = i;
    end
end


signature_f = signature_bin (debut : fin); % on recupere le debut et la fin de notre signature


figure;
plot(signature_f);


u = floor(N/95)+1;


%% reechantillonage de la signature non binarisee et non echantilloner

step=(fin-debut)/(u*95);

for k=1:u*95
    code(k)=signature(round(k*step)); %interpolation
end

%% binarisation de la seconde signature


for k = 1:length(code)
    if(code(k)>seuil)
        signature_bin_2(k) = 1 ;
    else
        signature_bin_2(k) = 0;
    end
end

figure;
plot(signature_bin_2)

title('Binarisation de la nouvelle signature extraite');

%% Division de notre segment en 12 parties

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
% for j=1:10
%     Seg() = 
% end
[value] = sign2num(u,sig_11);

