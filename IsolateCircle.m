function [imageOutput,monCentroide,rayon] = IsolateCircle(image,seuilContrast,SeuilSelEtPoivre)
%ISOLATECIRCLE Summary of this function goes here
% Fonction qui isole le cercle de la cannette et retourne le centre de
% celui-ci, 

% Fonctionnment
% 1- Filtre médiant et moyennant pour réduire l'apparition du "sel" pour plus
% tard
% 2- On applique un filtre de gradient en x et en y,
% 3- On élimine la plupart de des faibles intensités en appliquant un contraste (seuilContrast)
% 4- On élimine tout le "sel" en utilisant les statistiques des régions
% présente sur l'image
% 5- On élimine toutes les régions qui sont trop excentrique pour ne laisser que la région qui ressemble le plus à un cercle 
% 6- On applique une transformation morphologique de fermeture pour éliminer
% les "gap" entre les pixels
% 7- On aminci au maximum la région pour ensuite obtenir le centroide de la
% forme
%   Detailed explanation goes here



for i=1:length(image)


%1- Filtre médiant et moyennant pour réduire l'apparition du "sel" pour plus
%tard
F{i} = imfilter(image{i}, ones(3)/9, 'symmetric');
F{i} = medfilt2(F{i},[36,36]);
%1- END
%figure(i), imshow(F{i},[]);
%2- On applique un filtre de gradiant en x et en y,
F{i} = imgradient(F{i});
%2- END
%figure(i+10), imshow(F{i},[0,100]);

%3- On élimine la plus part de des faibles intensités en appliquant un contraste (seuilContrast)
F{i} = (F{i} > seuilContrast);                  
%figure(i+20),imshow(F{i});
%3- END
se = strel('disk',10);
F{i} = imclose(F{i},se);
%figure(30),imshow(F{i});
%4- On élimine tout le "sel" en utilisant les statistiques des régions
%présente sur l'image
stats = regionprops(F{i}, 'Area','PixelList');
Filtre = zeros(size(F{i}));
FiltreTemp = zeros(size(F{i}));
    for i2 = 1: size(stats,1)
        if (stats(i2).Area > SeuilSelEtPoivre)
          pix = sub2ind(size(F{i}), uint16(stats(i2).PixelList(:,2)), uint16(stats(i2).PixelList(:,1)));
          FiltreTemp(pix) = 1;
          Filtre = logical(Filtre + FiltreTemp);
        end
    end
imageOutput{i}= Filtre;
%figure(20+i),imshow(imageOutput{i},[]);
%4- END

se = strel('disk',2);
imageOutput{i} = imdilate(imageOutput{i},se);

%figure(40+i),imshow(imageOutput{i},[]);
x = 0;
y = 0;
%5- On élimine toutes les régions qui sont trop excentrique pour ne laisser que la région qui ressemble le plus à un cercle 
stats = regionprops(logical(imageOutput{i}), 'Centroid','Eccentricity','Area','PixelList');
Filtre = zeros(size(F{i},1),size(F{i},2));
for k = 1: size(stats,1)
myMinArray(k) =  stats(k).Eccentricity;
end

    for i2 = 1: size(stats,1)
        
        if (stats(i2).Eccentricity == min(myMinArray))
            for nb_pair= 1:size(stats(i2).PixelList(:,:),1)      
                x = stats(i2).PixelList(nb_pair,1);
                y = stats(i2).PixelList(nb_pair,2);
                Filtre(y,x) = true;         
            end
            %imageOutput{i}(stats(i2).PixelList) = 0;
        end
    end
clear myMinArray
imageOutput{i}= Filtre;
%figure(i+50),imshow(imageOutput{i},[]);
%5-END  

%6- On applique une transformation morphologique de fermeture pour éliminer
%les "gap" entre les pixels
se = strel('disk',150);
imageOutput{i} = imclose(imageOutput{i},se);
%6- End

%7- On aminci au maximum la région pour ensuite obtenir le centroide de la
%forme
imageOutput{i} = bwmorph(imageOutput{i},'thin',Inf);
monCentroide{i} = regionprops(imageOutput{i}, 'Centroid').Centroid;
%7-End
side = 4;
%figure(60+i),imshow(imageOutput{i},[]);
%r1 = drawrectangle('Position',[monCentroide{i}(1)-(side/2) ,monCentroide{i}(2)-(side/2) ,side,side],'Color','r');

stats = regionprops(imageOutput{i},'PixelList');
rayon{i} = max(sqrt((monCentroide{i}(1,1) - stats.PixelList(:,1)).^2+(monCentroide{i}(1,2)-stats.PixelList(:,2)).^2));

end
end

