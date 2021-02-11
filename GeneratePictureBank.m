%Fonction qui permet de générer une banque d'image pour l'entrainement du
%réseau de neuronne en déformant légèrement quelques images de bases et en
%appliquant des transformations aléatoire


%
nbGenerated = 9; %nombre de photo généré de plus par photo de base
%
PictureBaseFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\Picture_Bank\BaseBank';
[pictureGray,picture] = GetPicture(PictureBaseFile);

pictureGray = GenerateTransformedPicture(pictureGray, nbGenerated);