function ShowWithSubPlot(imageTest,generatedNum)
%SHOWWITHSUBPLOT Summary of this function goes here
%Fonction qui affiche les photos avec un subplote (affichage cote à cote
%des images)
%   Detailed explanation goes here

nb_image = length(imageTest);

for i = 1:nb_image
figure(1),
subplot(1,nb_image,i),imshow(imageTest{i},[]), title(['Image ',num2str(generatedNum(i))]);
end


end

