function [ val  ] = last_num(tab )
%% help 
% prend en entrée le tableau des chiffres du code barre deja decodés
%renvoi la valeur du dernier chiffre du code barre


%on effectue la somme des elements impairs
sum_impair = tab(1) + tab(3) + tab(5) + tab(7) + tab(9) + tab(11);

% on effectue 3 fois la somme des elements pairs
sum_pair = 3*(tab(2) + tab(4) + tab(6) + tab(8) + tab(10) +tab(12));

%on effectue la somme
sum = sum_pair + sum_impair;

% on  récupere le chiffre des unités 
val = mod(sum,10);

val = 10 - val;
% on renvoie le complément à 10


end

