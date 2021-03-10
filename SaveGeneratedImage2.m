function [] = SaveGeneratedImage2(GeneratedImage,SaveFile,ProgramFile)
%SAVEIMAGE Summary of this function goes here
%Sauvegarde les images dans le dossier "SaveFile"
%Prend en argument la matrice des images, le répertoire "SaveFile" et le
%répertoire ProgramFile où le code est sauvegarder

%Sauvegarde seulement les images générées


%   Detailed explanation goes here

cd(SaveFile)
for k = 1:numel(GeneratedImage)   
  fileName = sprintf('image_%04d.jpg', i+k);     
  imwrite( GeneratedImage{k}, fileName);  
end

cd(ProgramFile)
end

