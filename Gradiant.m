function [F] = Gradiant(image)
%GRADIANT Summary of this function goes here
%   Detailed explanation goes here
hx = [-1 -2 -1 ;
    0 0 0;
    1 2 1;];
hy = hx';

gx = imfilter(image,hx);
gy = imfilter(image,hy);

F = abs(gx) + abs(gy);
end

