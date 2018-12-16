function [chif,alphabet] = sign2num(u,segment)

%% initialisation des variables
chif = -1;
nberrmax = 20;

%% 1 - Construction d'une signature theorique de longeur 7
% element A
A = zeros(10,7);
A(1,:) = [1 1 1 0 0 1 0];
A(2,:) = [1 1 0 0 1 1 0];
A(3,:) = [1 1 0 1 1 0 0];
A(4,:) = [1 0 0 0 0 1 0];
A(5,:) = [1 0 1 1 1 0 0];
A(6,:) = [1 0 0 1 1 1 0];
A(7,:) = [1 0 1 0 0 0 0];
A(8,:) = [1 0 0 0 1 0 0];
A(9,:) = [1 0 0 1 0 0 0];
A(10,:) = [1 1 1 0 1 0 0];

%element B
B = zeros(10,7);
B(1,:) = [1 0 1 1 0 0 0 ];
B(2,:) = [1 0 0 1 1 0 0 ];
B(3,:) = [1 1 0 0 1 0 0 ];
B(4,:) = [1 0 1 1 1 1 0 ];
B(5,:) = [1 1 0 0 0 1 0 ];
B(6,:) = [1 0 0 0 1 1 0 ];
B(7,:) = [1 1 1 1 0 1 0 ];
B(8,:) = [1 1 0 1 1 1 0 ];
B(9,:) = [1 1 1 0 1 1 0 ];
B(10,:) = [1 1 0 1 0 0 0 ];

% element C
C = zeros(10,7);
C(1,:) = [0 0 0 1 1 0 1];
C(2,:) = [0 0 1 1 0 0 1];
C(3,:) = [0 0 1 0 0 1 1];
C(4,:) = [0 1 1 1 1 0 1];
C(5,:) = [0 1 0 0 0 1 1];
C(6,:) = [0 1 1 0 0 0 1];
C(7,:) = [0 1 0 1 1 1 1];
C(8,:) = [0 1 1 1 0 1 1];
C(9,:) = [0 1 1 0 1 1 1];
C(10,:) = [0 0 0 1 0 1 1];

%% 2 - Dillatation de la signature theorique sth en fonction de l'unite u


for j = 1:10
    A1 = [];
    B1 = [];
    C1 = [];
    for i =1 :7
        if A(j,i) ==1
            A1 =[A1 ones(1,u)];
        else
            A1 = [A1 zeros(1,u)];
        end
        if B(j,i) ==1
            B1 =[B1 ones(1,u)];
        else
            B1 = [B1 zeros(1,u)];
        end
        if C(j,i) ==1
            C1 =[C1 ones(1,u)];
        else
            C1 = [C1 zeros(1,u)];
        end
        
    end
    A2(j,:) = A1;
    B2(j,:) = B1;
    C2(j,:) = C1;
end


%% 3 - Mesure de la ressemblance de la signature theorique avec la signature partielle observée après comptage du nombre de différences selon la formulation

% for k = 1:10
%     nbdifa = zeros(1,10);
%     nbdifb = zeros(1,10);
%     nbdifc = zeros(1,10);
%     for w = 1 : 7*u        
%         if segment(w) ~= A2(k,w)
%             nbdifa(k) = nbdifa(k) +1;     
%         elseif segment(w) ~= B2(k,w)
%             nbdifb(k) = nbdifb(k) +1;
%         elseif segment(w) ~= C2(k,w)
%             nbdifc(k) = nbdifc(k) +1;
%         end
%     end
%     nba = min(nbdifa);
%     nbb = min(nbdifb);
%     nbc = min(nbdifc);
%     nb = min([nba nbb nbc]);
%     if nb < nberrmax
%         chiftab(k) = k-1;
%     end
% end

% chif=min(chiftab);

nbdif1 = zeros(1,10);
norm = [];
for k = 1:10  
    norm = abs(segment-A2(k,:));
    nbdif1(k) = sum(norm);
end

nbdif2 = zeros(1,10);

for k = 1:10  
    norm = abs(segment-B2(k,:));
    nbdif2(k) = sum(norm);
end

nbdif3 = zeros(1,10);

for k = 1:10  
    norm = abs(segment-C2(k,:));
    nbdif3(k) = sum(norm);
end

[mini1 ,chif1] = min(nbdif1);
[mini2 ,chif2] = min(nbdif2);
[mini3 ,chif3] = min(nbdif3);
[min_final]  = min([mini1 mini2 mini3]);

if min_final == mini1 
    chif = chif1;
    alphabet = 'A';
elseif  min_final == mini2
    chif = chif2;
    alphabet = 'B';
elseif min_final == mini3
    chif = chif3;
    alphabet = 'C';
end 

chif = chif-1;
end
