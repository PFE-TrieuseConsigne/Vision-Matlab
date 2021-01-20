function [imageTest,generatedNum] = SelectRandomPicture(nb_image,picture)
%SELECTRANDOMPICTURE Summary of this function goes here
%Sélectionne un nombre "nb_image" de photo dans "picture" de façon
%aléatoire, sans avoir 2 fois la même photo.
%   Detailed explanation goes here
if nb_image > length(picture)
   errorMessage = sprintf('Baisser le nombre d''image que l''on veut observer');
  uiwait(warndlg(errorMessage)); 
end

generatedNum(1) = 0;
for i = 1:nb_image
    randnum = randi(length(picture));

    while ismember(randnum,generatedNum)
        randnum = randi(length(picture));
    end
    generatedNum(i) = randnum;
    imageTest(i)=  picture(randnum);
end

end

