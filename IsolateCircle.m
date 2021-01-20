function [imageOutput,monCentroide] = IsolateCircle(image,seuilContrast,SeuilSelEtPoivre)
%ISOLATECIRCLE Summary of this function goes here
% Fonction qui isole le cercle de la cannette et retourne le centre de
% celui-ci, 

%Fonctionnment
%1- On applique un filtre de gradiant en x et en y,
%2- Filtre médiant et moyennant pour réduire l'apparition du "sel" pour plus
%tard
%3- On élimine la plus part de des faibles intensités en appliquant un contraste (seuilContrast)
%4- On élimine tout le "sel" en utilisant les statistiques des régions
%présente sur l'image
%5- On élimine toutes les régions qui sont trop excentrique pour ne laisser que la région qui ressemble le plus à un cercle 
%6- On applique une transformation morphologique de fermeture pour éliminer
%les "gap" entre les pixels
%7- On aminci au maximum la région pour ensuite obtenir le centroide de la
%forme
%   Detailed explanation goes here



for i=1:length(image)
%1- On applique un filtre de gradiant en x et en y,
F{i} = Gradiant(image{i});
%1- END

%2- Filtre médiant et moyennant pour réduire l'apparition du "sel" pour plus
%tard
%figure(10), imshow(image_magn,[]);
F{i} = imfilter(F{i}, ones(4)/16, 'symmetric');
F{i} = medfilt2(F{i},[6,6]);
%2- END

%3- On élimine la plus part de des faibles intensités en appliquant un contraste (seuilContrast)
F{i} = (F{i} > seuilContrast);                  
%figure(11),imshow(image_C2);
%3- END

%4- On élimine tout le "sel" en utilisant les statistiques des régions
%présente sur l'image
stats = regionprops(F{i}, 'Area','PixelList');
Filtre = zeros(size(F{i},1),size(F{i},2));

    for i2 = 1: size(stats,1)
        if (stats(i2).Area < SeuilSelEtPoivre)
            for nb_pair= 1:size(stats(i2).PixelList(:,:),1)  %parcours de 1 à 6 les collomnes    
                x = stats(i2).PixelList(nb_pair,1);
                y = stats(i2).PixelList(nb_pair,2);
                Filtre(y,x) = true;
            end
        end
    end
imageOutput{i}= F{i} - logical(Filtre);
%figure(10+i),imshow(imageOutput{i},[]);
%4- END

x = 0;
y = 0;
%5- On élimine toutes les régions qui sont trop excentrique pour ne laisser que la région qui ressemble le plus à un cercle 
stats = regionprops(logical(imageOutput{i}), 'Centroid','Eccentricity', 'PixelList');
Filtre = zeros(size(F{i},1),size(F{i},2));

    for i2 = 1: size(stats,1)
        if (stats(i2).Eccentricity > min(stats(1).Eccentricity))
            for nb_pair= 1:size(stats(i2).PixelList(:,:),1)      
                x = stats(i2).PixelList(nb_pair,1);
                y = stats(i2).PixelList(nb_pair,2);
                Filtre(y,x) = true;
            end
        end
    end
imageOutput{i}= logical(imageOutput{i} - logical(Filtre));
%figure(100),imshow(imageOutput{i},[]);
%5-END  

%6- On applique une transformation morphologique de fermeture pour éliminer
%les "gap" entre les pixels
se = strel('disk',50);
imageOutput{i} = imclose(imageOutput{i},se);
%6- End

%7- On aminci au maximum la région pour ensuite obtenir le centroide de la
%forme
imageOutput{i} = bwmorph(imageOutput{i},'thin',Inf);
monCentroide = regionprops(logical(imageOutput{i}), 'Centroid').Centroid;
%7-End
side = 4;
figure(30+i),imshow(imageOutput{i},[]);
r1 = drawrectangle('Position',[monCentroide(1)-(side/2) ,monCentroide(2)-(side/2) ,side,side],'Color','r');
end
end

