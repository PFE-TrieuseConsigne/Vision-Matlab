function [pictureGray,imageArray] = GetPicture(myFolder)

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
  imageArray{k} = imread(fullFileName);
  %imshow(imageArray{1});  % Display image 1.
 % drawnow; % Force display to update immediately.
  pictureGray{k} = rgb2gray(imageArray{k});
end



end
