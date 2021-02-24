function [imageOutput] = RemoveBackground(image,centreCercle,rayon)
%REMOVEBACKGROUND Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(image)


[M,N,~] = size(image{i});
[v,u]=meshgrid(1:N,1:M);
H = double(sqrt((u-centreCercle{i}(2)).^2+(v-centreCercle{i}(1)).^2)) < rayon{i}*1.05;

%figure(150+i),imshow(H);
imageOutput{i} = double(image{i}).*H; 
%figure(200+i),imshow(imageOutput{i},[]);
end
end

