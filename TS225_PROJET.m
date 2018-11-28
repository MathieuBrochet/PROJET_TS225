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

%% reechantillonage

step=(fin-debut)/(u*95);

for k=1:u*95
    code(k)=signature_f(round(k*step)); %interpolation
end



subplot(2,1,2);
plot(code)

