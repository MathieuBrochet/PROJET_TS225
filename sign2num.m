function [ chiffre ] = sign2num( signature )

B = zeros(7,10);
B(:,1) = [1 0 1 1 0 0 0 ];
B(:,2) = [1 0 0 1 1 0 0 ];
B(:,3) = [1 1 0 0 1 0 0 ];
B(:,4) = [1 0 1 1 1 1 0 ];
B(:,5) = [1 1 0 0 0 1 0 ];
B(:,6) = [1 0 0 0 1 1 0 ];
B(:,7) = [1 1 1 1 0 1 0 ];
B(:,8) = [1 1 0 1 1 1 0 ];
B(:,9) = [1 1 1 0 1 1 0 ];
B(:,10) = [1 1 0 1 0 0 0 ];

end