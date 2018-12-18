function [ Iy,Ix ] = canny( sigmag2,image )

[X,Y] = meshgrid(-sigmag2 : sigmag2); % en fonction de sigmag

deriv_y = -2*(Y/(2*pi*sigmag2^2)).*exp(-(X.^2+Y.^2)/(2*sigmag2));
deriv_x = -2*(X/(2*pi*sigmag2^2)).*exp(-(X.^2+Y.^2)/(2*sigmag2));

Ix = conv2(image,deriv_x,'same');
Iy  = conv2(image,deriv_y,'same');

end

