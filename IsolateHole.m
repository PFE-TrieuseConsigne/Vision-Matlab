function [imageOutput,monCentroide] = IsolateHole(image,seuilContrast,centreCercle)
%ISOLATEHOLE Summary of this function goes here
%   Fonction qui isole le centre de la canette avec son troue, retourne le
%   centroide du trou 


for i=1:length(image)    
F{i} = Gradiant(image{i});
F{i} = imfilter(F{i}, ones(4)/16, 'circular');

%figure(i),imshow(F{i},[]);
F{i} = medfilt2(F{i},[6,6]);
F{i} = (F{i} < seuilContrast);
%figure(i+10),imshow(F{i},[]);
stats = regionprops(F{i}, 'Centroid','pixellist','area');
index = NaN;
%Retient la région qui comprend le centroide
  for i2 = 1: size(stats,1)     
        if (max(ismember(stats(i2).PixelList(:,:),uint16(centreCercle{i}),'row')))
            index = i2;
            break
        end        
  end
 %
 
%Crée un filtre de la région en question 
holePixel(:,1) = uint16(stats(index).PixelList(:,2));
holePixel(:,2) = uint16(stats(index).PixelList(:,1));
pix = sub2ind(size(F{i}), holePixel(:,1), holePixel(:,2));
Filtre = logical(zeros(size(F{i})));
Filtre(pix) = 1;

se = strel('disk',10);
Filtre = imclose(Filtre,se);
%

%Détermine le centroid du trou
stats = regionprops(Filtre,'Centroid');
%figure(i+20),imshow(F{i},[]);
monCentroide{i} = stats(1).Centroid;
side = 4;


image{i}(Filtre) = 0;
imageOutput{i} = image{i};
figure(30+i),imshow(imageOutput{i},[]);
r1 = drawrectangle('Position',[monCentroide{i}(1)-(side/2) ,monCentroide{i}(2)-(side/2) ,side,side],'Color','r');
r2 = drawrectangle('Position',[centreCercle{i}(1)-(side/2) ,centreCercle{i}(2)-(side/2) ,side,side],'Color','b');
clear holePixel;
clear r1;
clear r2;
end


end

