%Fonction qui permet de générer une banque d'image pour l'entrainement du
%réseau de neuronne en déformant légèrement quelques images de bases et en
%appliquant des transformations aléatoire


%
nbGenerated = 1; %nombre de photo généré de plus par photo de base
%
PictureBaseFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\Picture_Bank\BaseBank';
SaveFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\Picture_Bank\PictureBank_02-08-20201';
ProgramFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\Code';
[pictureGray,picture] = GetPicture(PictureBaseFile);

generatedPicture = GenerateTransformedPicture(pictureGray, nbGenerated);
SaveGeneratedImage(pictureGray,generatedPicture,SaveFile,ProgramFile);

