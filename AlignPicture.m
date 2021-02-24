function [imageOutput,filtreHole] = AlignPicture(image,centreCercle,centreTroue,filtreHole)
%Fonction qui alligne la photo et met le centroide au centre

%

    for i=1:length(image)     
        image{i} = uint8(image{i});
        
        centreX = size(image{i},2)/2;
        centreY = size(image{i},1)/2;
        
        distX = int16(centreCercle{i}(1,1)-centreX);
        distY = int16(centreY-centreCercle{i}(1,2));
        

        
        image{i} = imtranslate(image{i},[-distX,distY]);
        %figure(i),imshow(image{i},[]);
        %r1 = drawrectangle('Position',[centreCercle{i}(1,1)-distX-(4/2) ,centreCercle{i}(1,2)+distY-(4/2) ,4,4],'Color','r');
        
        centreTroue{i}(1,1) = centreTroue{i}(1,1) - distX;
        centreTroue{i}(1,2) = centreTroue{i}(1,2) + distY;
        distX = int16(centreTroue{i}(1,1)- centreX);
        distY = int16(centreY - centreTroue{i}(1,2));
        
        if(abs(distY) > abs(distX)) %ligne verte 
        angleRot = tand(double(distX)/double(distY));
            if(distX>0 && distY>0) %cad 1
                angleRot = -(180-angleRot);          
            elseif(distX>0 && distY<=0) %cad 2
                angleRot = -angleRot;    
            elseif(distX<=0 && distY<=0)%cad 3
                angleRot = angleRot;
            elseif(distX<0 && distY>0)%cad 4
                angleRot = -(180 + angleRot);
            end
        else %ligne bleu
        angleRot = tand(double(distY)/double(distX));    
            if(distX>0 && distY>0) %cad 1
                angleRot = -(90+angleRot);          
            elseif(distX>0 && distY<=0) %cad 2
                angleRot = -(90-angleRot);    
            elseif(distX<=0 && distY<=0)%cad 3
                angleRot = -(angleRot-90);
            elseif(distX<0 && distY>0)%cad 4
                angleRot = -(-90-angleRot);
            end
        
        end
        imageOutput{i} = imrotate(image{i},angleRot, 'nearest','crop');
        filtreHole{i} = imrotate(filtreHole{i},angleRot, 'nearest','crop');
        %figure(10+i),imshow(imageOutput{i},[]);

        
        
        
    end
end