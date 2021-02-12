function [imageOutput] = Barrel(I)
%BARREL Summary of this function goes here
%   Detailed explanation goes here


nrows = size(I,1);
ncols = size(I,2);
fill = 0.3;

%figure(3),imshow(I)
%title('Original');


[xi,yi] = meshgrid(1:ncols,1:nrows);
xt = xi - ncols/2;
yt = yi - nrows/2;
[theta,r] = cart2pol(xt,yt);
a = rand * 0.5 +1; % Try varying the amplitude of the cubic term.
rmax = max(r(:));
s1 = r + r.^3*(a/rmax.^2);
[ut,vt] = pol2cart(theta,s1);
ui = ut + ncols/2;
vi = vt + nrows/2;
ifcn = @(c) [ui(:) vi(:)];
tform = geometricTransform2d(ifcn);

imageOutput = imwarp(I,tform,'FillValues',fill);
Filtre = ~imageOutput;
stats = regionprops(Filtre,'pixellist','area');

imageOutput(Filtre) = 162;

%figure(6),imshow(imageOutput)
%title('Barrel');





end

