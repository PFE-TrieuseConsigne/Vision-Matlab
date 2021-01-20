function [imageOutput] = RemoveBackground(image,centreCercle,rayon)
%REMOVEBACKGROUND Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(image)


[M,N,~] = size(image{i});
[v,u]=meshgrid(1:N,1:M);
H = double(sqrt((u-M/2).^2+(v-N/2).^2)) < rayon{i};

figure(150+i),imshow(H);
imageOutput{i} = double(image{i}).*H; 
figure(200+i),imshow(imageOutput{i},[]);
end
end

