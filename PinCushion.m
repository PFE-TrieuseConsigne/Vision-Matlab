function [imageOutput] = PinCushion(I)
%UNTITLED Summary of this function goes here
%Fonction qui applique un filtre PinCushion à l'image
%   Detailed explanation goes here

nrows = size(I,1);
ncols = size(I,2);
fill = 0.3;
% figure(1), imshow(I)
% title('Original');

b = (rand * 0.08)+0.02; % Try varying the amplitude of the cubic term.
[xi,yi] = meshgrid(1:ncols,1:nrows);
xt = xi - ncols/2;
yt = yi - nrows/2;
[theta,r] = cart2pol(xt,yt);
rmax = max(r(:));
s = r - r.^3*(b/rmax.^2);

[ut,vt] = pol2cart(theta,s);
ui = ut + ncols/2;
vi = vt + nrows/2;

ifcn = @(c) [ui(:) vi(:)];
tform = geometricTransform2d(ifcn);
imageOutput = imwarp(I,tform,'FillValues',fill);


% figure(2),imshow(I_pin)
% title('Pin Cushion');
end

