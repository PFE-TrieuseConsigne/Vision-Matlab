
ProgramFile = 'E:\École\ETS\PFE\Vision-Matlab';
Xsize = 227;
Ysize = 227;


PictureFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\PictureDataNetwork\Droite';
OutputFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\PictureDataNetwork\TrainingData\AvecDroite';
[pictureGray] = GetPictureGray(PictureFile);
for i = 1:numel(pictureGray)
   ImageOutPut{i} = imresize(pictureGray{i},[Xsize Ysize]);
end

SaveGeneratedImage2(ImageOutPut,OutputFile,ProgramFile);
clear ImageOutPut
clear pictureGray


PictureFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\PictureDataNetwork\Gauche';
OutputFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\PictureDataNetwork\TrainingData\AvecGauche';
[pictureGray] = GetPictureGray(PictureFile);
for i = 1:numel(pictureGray)
   ImageOutPut{i} = imresize(pictureGray{i},[Xsize Ysize]);
end

SaveGeneratedImage2(ImageOutPut,OutputFile,ProgramFile);
clear ImageOutPut
clear pictureGray


PictureFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\PictureDataNetwork\SANSDroite';
OutputFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\PictureDataNetwork\TrainingData\SansDroite';
[pictureGray] = GetPictureGray(PictureFile);
for i = 1:numel(pictureGray)
   ImageOutPut{i} = imresize(pictureGray{i},[Xsize Ysize]);
end

SaveGeneratedImage2(ImageOutPut,OutputFile,ProgramFile);
clear ImageOutPut
clear pictureGray



PictureFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\PictureDataNetwork\SANSGauche';
OutputFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\PictureDataNetwork\TrainingData\SansGauche';
[pictureGray] = GetPictureGray(PictureFile);
for i = 1:numel(pictureGray)
   ImageOutPut{i} = imresize(pictureGray{i},[Xsize Ysize]);
end

SaveGeneratedImage2(ImageOutPut,OutputFile,ProgramFile);
clear ImageOutPut
clear pictureGray







