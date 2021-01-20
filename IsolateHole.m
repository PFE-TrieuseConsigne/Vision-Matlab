function [imageOutput,monCentroide] = IsolateHole(image,seuilContrast)
%ISOLATEHOLE Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(image)
F{i} = Gradiant(image{i});
F{i} = imfilter(F{i}, ones(4)/16, 'circular');

figure(10+i),imshow(F{i},[]);
F{i} = medfilt2(F{i},[6,6]);
F{i} = histeq(F{i});
F{i} = (F{i} > seuilContrast);   
figure(1+i),imshow(F{i},[]);
end


end

