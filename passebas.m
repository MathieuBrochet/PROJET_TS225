function [Wxy] = passebas(sigmat2)

M = sigmat2*3;
x = -M:M;

[X,Y] = meshgrid(x); % en fonction de sigmat2
Wxy = (1/(2*pi*sigmat2)).*exp(-(X.^2+Y.^2)/(2*sigmat2));



end

