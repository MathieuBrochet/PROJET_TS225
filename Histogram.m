function [ hist ] = Histogram(signature,N1,N)
%% 1- initialisation des variables

hist = zeros(1,N1); % initialisation du vecteur contenant les valeurs de l'histogramme

%% 2 - implementation de l'agorithme histogramme
for i = 1 : N1
    for k = 1:N
        if (signature(k) == i)
            hist(i) = hist(i) +  1;
        end
    end
end

end

