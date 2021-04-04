function [] = SaveImage(Image,SaveFile,ProgramFile)
%SAVEIMAGE Summary of this function goes here
%Sauvegarde les images dans le dossier "SaveFile"
%Prend en argument la matrice des images, le répertoire "SaveFile" et le
%répertoire ProgramFile où le code est sauvegarder

%Cette fonction les sépares en images de droite vs images de gauches

%   Detailed explanation goes here

cd(SaveFile)
indexG = 1;
indexD = 1;
for i = 1:numel(Image)
    if (i<=(numel(Image)/2)) %Image de gauche
          fileName = sprintf('imageDroite_%04d.jpg', indexG);   
          indexG = indexG +1;
    else %Image de droite
          fileName = sprintf('imageGauche_%04d.jpg', indexD);    
          indexD = indexD +1;
    end
  imwrite( Image{i}, fileName);
  
end
cd(ProgramFile)
end

