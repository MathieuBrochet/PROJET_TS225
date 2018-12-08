function [crit] = Otsu(hist,N1)
%help


%% 1 - initialisation des variables
max =0;
MU = 0 ;
W = 0;
crit = zeros(1,N1);
w_num = zeros(1,N1);
mu_num = zeros(1,N1);

%% 2 - Calcul du critere par l'algorithme d'Otsu

w_den = sum(hist);

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

end

