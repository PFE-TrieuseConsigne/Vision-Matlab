function [imageOutput] = RemoveMiddle(image,centreCercle,rayon)
%REMOVEMIDDLE Summary of this function goes here
%On perce un trou dans au centre de l'image.
%Fonction qui prend l'image, le centre du cercle et sont rayon et crée un
%filtre ciculaire (H) à la position du centre du cercle et de rayon ''rayon''
%pour enlever 
%   Detailed explanation goes here

for i=1:length(image)
[M,N,~] = size(image{i});
[v,u]=meshgrid(1:N,1:M);
%H est le filtre ciculaire
H = double(sqrt((u-centreCercle{i}(2)).^2+(v-centreCercle{i}(1)).^2)) < rayon{i}*0.45;
%H2 est un filtre circulaire légèrement plus gros que H 
H2 = double(sqrt((u-centreCercle{i}(2)).^2+(v-centreCercle{i}(1)).^2)) <= rayon{i}*0.55 ;
%On vient former un baignait (H2-H) pour y calculer l'intensité min et
%moyenne de cette région
circleOutLine = H2 - H;

minSeuilContrast = min(image{i}(circleOutLine(:)~=0));
meanSeuilContrast = mean(image{i}(circleOutLine(:)~=0));
%On calcule un seuil de contrast selon l'intensité min et moyenne du
%baignait
SeuilContrast = minSeuilContrast + 0.05 * meanSeuilContrast;
imageOutput{i} = image{i};
%On applique le seuil de contrast
imageOutput{i}(H) = SeuilContrast; 
%figure(300+i),imshow(imageOutput{i},[]);
end

end

