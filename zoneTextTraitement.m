function [imageOutput] = ZoneTextTraitement(image,FiltreBase)
%ZONETEXTTRAITEMENT Summary of this function goes here
%   Detailed explanation goes here
petiteRegion = 45;
GrosseRegion = 10000;
indexG = 1;
indexD = 1;
for i = 1:numel(FiltreBase)
    if(-1==(-1)^i) %Image de gauche
        FiltreG{indexG} = FiltreBase{i};
        indexG = indexG+1;   
    else
        FiltreD{indexD} = FiltreBase{i};
        indexD = indexD +1;       
    end
end
clear indexG indexD;
Filtre(:,1) = FiltreG;
Filtre(:,2) = FiltreD;




for i = 1:numel(image)
    averageGray = mean(image{i}(Filtre{i}(:)~=0)); %On calcule l'intensité moyenne de la région de gravure
    seuil = uint16(averageGray* 0.1287);            %On calcule un seuil en fonction de cette intensité
    
    %Prétraitement
    imageOutput{i} = imfilter(image{i}, ones(6)/36, 'symmetric');
    %figure(1),imshow(imageOutput{i});
    imageOutput{i} = medfilt2(imageOutput{i},[6,6]);
    %figure(2),imshow(imageOutput{i});

    imageOutput{i} = imgradient(imageOutput{i});
    %figure(3),imshow(imageOutput{i},[]);
    imageOutput{i} = (imageOutput{i}>seuil);
    %    figure(4),imshow(imageOutput{i});
    se = strel('disk',2);
    imageOutput{i} = imclose(imageOutput{i},se);
    
    %        figure(5),imshow(imageOutput{i});
    
    %On élimine les régions trops petites
    stats = regionprops(imageOutput{i}, 'Area', 'PixelList');
    FiltreSP = zeros(size(imageOutput{i}));
    FiltreTemp = zeros(size(imageOutput{i}));
    for i2 = 1: size(stats,1)
        if (stats(i2).Area > petiteRegion) %&& stats(i2).Area < GrosseRegion
          pix = sub2ind(size(imageOutput{i}), uint16(stats(i2).PixelList(:,2)), uint16(stats(i2).PixelList(:,1)));
          FiltreTemp(pix) = 1;
          FiltreSP = logical(FiltreSP + FiltreTemp);       
        end 
    end 
        imageOutput{i} = FiltreSP;
        figure(6),imshow(imageOutput{i});
end
end

