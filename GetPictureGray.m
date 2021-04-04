function [pictureGray] = GetPictureGray(myFolder)
%GETPICTUREGRAY Summary of this function goes here
%Fonction qui charge en mémoire les images en noir et blanc
%   Detailed explanation goes here
if ~isfolder(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.jpg');
jpegFiles = dir(filePattern);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  pictureGray{k} = imread(fullFileName);
end
end

