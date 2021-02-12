function [pictureOutput] = GenerateTransformedPicture(pictureGray, nbGenerated)
%GENERATETRANSFORMEDPICTURE Summary of this function goes here
%   Detailed explanation goes here

pictureOutput = cell([1 length(pictureGray)*nbGenerated]);
for i=1:length(pictureGray)
    for k=1:nbGenerated
        x = round(rand);
        if(x ==1)
        pictureOutput{k+(i-1)*nbGenerated} = Barrel(pictureGray{i});

        else
        pictureOutput{k+(i-1)*nbGenerated} = PinCushion(pictureGray{i}); 
        end        
    end
end
end

