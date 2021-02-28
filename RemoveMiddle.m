function [imageOutput] = RemoveMiddle(image,centreCercle,rayon)
%REMOVEMIDDLE Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(image)
[M,N,~] = size(image{i});
[v,u]=meshgrid(1:N,1:M);
H = double(sqrt((u-centreCercle{i}(2)).^2+(v-centreCercle{i}(1)).^2)) < rayon{i}*0.45;
H2 = double(sqrt((u-centreCercle{i}(2)).^2+(v-centreCercle{i}(1)).^2)) <= rayon{i}*0.55 ;
circleOutLine = H2 - H;

minSeuilContrast = min(image{i}(circleOutLine(:)~=0));
meanSeuilContrast = mean(image{i}(circleOutLine(:)~=0));

SeuilContrast = minSeuilContrast + 0.05 * meanSeuilContrast;
imageOutput{i} = image{i};
imageOutput{i}(H) = SeuilContrast; 
%figure(300+i),imshow(imageOutput{i},[]);
end

end

