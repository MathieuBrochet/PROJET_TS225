function [Wxy] = passebas(sigmat2)

[X,Y] = meshgrid(-sigmat2 : sigmat2 ); % en fonction de sigmat2
Wxy = (1/(2*pi*sigmat2)).*exp(-(X.^2+Y.^2)/(2*sigmat2));



end

