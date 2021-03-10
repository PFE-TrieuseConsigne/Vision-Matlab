function [imageArray] = GetFiltre(myFolder)
%Fonction qui charge en mémoire les filtre 
if ~isfolder(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.png');
jpegFiles = dir(filePattern);

for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  %fprintf(1, 'Now reading %s\n', fullFileName);
  imageArray{k} = imread(fullFileName);
end
end

