function [ sign]  = decoupe(signature_bin_2,u  )
%help 


%% initialisation variable
sign = zeros(12,7*u);

%% 
sig_1 = signature_bin_2(3*u+1:3*u+7*u);
sign(1,:) = sig_1;
sig_2 = signature_bin_2(3*u+7*u+1:3*u+2*7*u);
sign(2,:) = sig_2;
sig_3 = signature_bin_2(3*u+2*7*u+1:3*u+3*7*u);
sign(3,:) = sig_3;
sig_4 = signature_bin_2(3*u+3*7*u+1:3*u+4*7*u);
sign(4,:) = sig_4;
sig_5 = signature_bin_2(3*u+4*7*u+1:3*u+5*7*u);
sign(5,:) = sig_5;
sig_6 = signature_bin_2(3*u+5*7*u+1:3*u+6*7*u);
sign(6,:) = sig_6;

sig_7 = signature_bin_2(5*u+3*u+6*7*u+1:5*u+3*u+7*7*u);
sign(7,:) = sig_7;
sig_8 = signature_bin_2(3*u+7*7*u+5*u+1:5*u+3*u+8*7*u);
sign(8,:) = sig_8;
sig_9 = signature_bin_2(5*u+3*u+8*7*u+1:5*u+3*u+9*7*u);
sign(9,:) = sig_9;
sig_10 = signature_bin_2(5*u+3*u+9*7*u+1:5*u+3*u+10*7*u);
sign(10,:) = sig_10;
sig_11 = signature_bin_2(5*u+3*u+10*7*u+1:5*u+3*u+11*7*u);
sign(11,:) = sig_11;
sig_12 = signature_bin_2(5*u+3*u+11*7*u+1:5*u+3*u+12*7*u);
sign(12,:) = sig_12;



end

