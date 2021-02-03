function [imageOutput] = zoneTextTraitement(image,FiltreBase)
%ZONETEXTTRAITEMENT Summary of this function goes here
%   Detailed explanation goes here
SeuilSelEtPoivre = 45;

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
    imageOutput{i} = Gradiant(image{i});
    imageOutput{i} = imfilter(imageOutput{i}, ones(4)/16, 'symmetric');
    imageOutput{i} = medfilt2(imageOutput{i},[6,6]);
    imageOutput{i} = (imageOutput{i}>35);

    stats = regionprops(imageOutput{i}, 'Area', 'PixelList');
    
    
    
    
    FiltreSP = zeros(size(imageOutput{i}));
    FiltreTemp = zeros(size(imageOutput{i}));
    for i2 = 1: size(stats,1)
        if (stats(i2).Area > SeuilSelEtPoivre)
          pix = sub2ind(size(imageOutput{i}), uint16(stats(i2).PixelList(:,2)), uint16(stats(i2).PixelList(:,1)));
          FiltreTemp(pix) = 1;
          FiltreSP = logical(FiltreSP + FiltreTemp);
        end
    end 
        imageOutput{i} = FiltreSP;
        
        FiltrePerim = bwperim(Filtre{i});
        se = strel('disk',16);
        FiltrePerim = imdilate(FiltrePerim,se);
        figure(i+30),imshow(FiltrePerim,[]);
        imageOutput{i} = uint8(imageOutput{i} - FiltrePerim);
        figure(i),imshow(imageOutput{i},[]);

        
end
end

