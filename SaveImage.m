function [] = SaveImage(Image,SaveFile,ProgramFile)
%SAVEIMAGE Summary of this function goes here
%Sauvegarde les images dans le dossier "SaveFile"
%Prend en argument la matrice des images, le répertoire "SaveFile" et le
%répertoire ProgramFile où le code est sauvegarder
%   Detailed explanation goes here

cd(SaveFile)
for i = 1:numel(Image)
  fileName = sprintf('image_%04d.jpg', i);
  imwrite( Image{i}, fileName);
end
cd(ProgramFile)
end

