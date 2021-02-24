function [imageOutput,newFiltre] = IsolateTextZone(image,rayon,FiltreBase,filtreHole)
%ISOLATETEXTZONE Summary of this function goes here
%   Detailed explanation goes here
RayonBase = 325*1.20;
filtreNb = 1;
%myfigure = 1;
for i2 = 1:length(image)
    for i3 = 1:length(FiltreBase)

        ratio = rayon{i2}/RayonBase;
    
        FiltreResized = logical(imresize(FiltreBase{i3},ratio));
        [Nf,Mf,~] = size(FiltreResized);
        [Ni,Mi,~] = size(image{i2});
        DeltaN = int16((Ni-Nf)/2);
        DeltaM = int16((Mi-Mf)/2);
        newFiltre{filtreNb} = zeros(size(image{i2}));
        if((DeltaN > 0) && (DeltaM > 0))%Si le filtre est plus petit, on rajoute des colonnes noirs
            [rows, columns] = size(FiltreResized); 
            newFiltre{filtreNb}(DeltaN+1:rows + DeltaN, DeltaM+1:columns+DeltaM, 1) = FiltreResized;  
        end
        clear FiltreResized;
        newFiltre{filtreNb} = logical(newFiltre{filtreNb}) - logical(filtreHole{i2});
        imageOutput{i2,i3} =  image{i2}.*uint8(newFiltre{filtreNb});
        
        %myfigure = myfigure + 1;
        %figure(myfigure),imshow(imageOutput{i2,i3});
        filtreNb = filtreNb+1;
    end
end
end

