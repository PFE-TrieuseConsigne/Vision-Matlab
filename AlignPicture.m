function [imageOutput] = AlignPicture(image,centreCercle,centreTroue)
%Fonction qui alligne la photo et met le centroide au centre

%

    for i=1:length(image)
        image{i} = uint8(image{i});
        
        centreX = size(image{i},2)/2;
        centreY = size(image{i},1)/2;
        
        distX = int16(centreX-centreCercle{i}(1,1));
        distY = int16(centreY-centreCercle{i}(1,2));
        pix = image{i} > 0;

        
        image{i} = imtranslate(image{i},[distX,distY]);
        %figure(i),imshow(image{i},[]);
        %r1 = drawrectangle('Position',[centreCercle{i}(1,1)+distX-(4/2) ,centreCercle{i}(1,2)+distY-(4/2) ,4,4],'Color','r');
        
        centreTroue{i}(1,1) = centreTroue{i}(1,1) + distX;
        centreTroue{i}(1,2) = centreTroue{i}(1,2) + distY;
        distX = int16(centreX - centreTroue{i}(1,1));
        distY = int16(centreY - centreTroue{i}(1,2));
        
        angleRot = rad2deg(tan(double(distY)/double(distX)));
        
        
        imageOutput{i} = imrotate(image{i},90+angleRot);
        %figure(10+i),imshow(imageOutput{i},[]);

    end
end