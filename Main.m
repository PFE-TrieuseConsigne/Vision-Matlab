%Fonction qui permet d'identifier le mot "Québec" sur une cannette vue de
%haut

%Fonctionnement
%1- On aligne la canette avec le diamètre extérieur et le ? troue ?
%2- Sachant l'alignement, on isole les parties de droite et gauche où il est écrit "Québec" et "Consignable" 
%On effectue des traitements sur ces nouvelle zone pour mieux faire sortir
%les gravures
%3- On sauvegarde les images dans un dossier avec la variable saveFile
%

%****************Définition des variables publique******************
%picture = Array de toutes les photos
%pictureGray = Array de toutes les photos en noir et blanc

%***Pour testé le code***
%nb_image = nombre de photo que l'on veut observer (pour débugger
%seulement)

%pictureNumber = les numéros des photos observé sélectionné aléatoirement
%selectedPicture = Les photos sélectionné aléatoirement 

%********MAIN START********
clc;
clear;

testingIsolement = true;
%testingIsolement = false;

%Variable que l'on peut modifier
%nb_image = 1;
%TestingWorkspaceFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\Workspace (debugging)'%Répertoire de débuggage pour sauver du temps lorsque testingIsolement == false
ProgramFile = 'E:\École\ETS\PFE\Vision-Matlab';                                     %Répertoire où le code MATLAB est sauvegarder (seulement utile lorsqu'on roule le code avec MATLAB?)
PictureFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\Picture_Bank\Picture_Test'; %Répertoire où l'on stock les images à traiter
SaveFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\ImageOuput';                   %Répertoire où l'on sauvegardera le résultat final
FiltreFile = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\FiltreZoneText';             %Répertoire des filtres pour isoler les zones de textes



if (testingIsolement)

    
%load les photos dans un array, un en noir et blanc, l'autre en couleur
[pictureGray] = GetPictureGray(PictureFile);
%[pictureGray,picture] = GetPicture(PictureFile);
%Load les filtres pour les zones de texte
[Filtre] = GetFiltre(FiltreFile);    

%Selectionne aléatoirement un nombre (nb_image) de photo pour affichage (pour le
%débuggage)
    %[selectedPicture,pictureNumber] = SelectRandomPicture(nb_image,pictureGray);
%Affiche les images sélectionné aléatoirement
    %ShowWithSubPlot(selectedPicture,pictureNumber)     

    
%1-On aligne la canette avec le diamètre extérieur et le ? troue ?    
%Isolation du diamètre extérieur
seuilHF = 6;
seuilContrast = 14;
SeuilSelEtPoivre = 30000;

imageHF = FiltreFrequentiel(pictureGray,seuilHF);
[imageCercle,centreCercle,rayon] = IsolateCircle(pictureGray,seuilContrast,SeuilSelEtPoivre);


%Enlève le fond (Background)
pictureGray = RemoveBackground(pictureGray,centreCercle,rayon);

%Enlève le milieu de la cannette
pictureGray = RemoveMiddle(pictureGray,centreCercle,rayon);

%Isolation du troue causé par la goupille
[pictureGray,centreTrou] = IsolateHole(pictureGray,20,centreCercle);

%Aligmenet de la cannette et centrage
[pictureGray] = AlignPicture(pictureGray,centreCercle,centreTrou);
%1-END



%2- Sachant l'alignement, on isole les parties de droite et gauche où il est écrit "Québec" et "Consignable" 
%Isolation de la zone de lettrage
%***********À Retravailler
[pictureGray,Filtre] = IsolateTextZone(pictureGray,rayon,Filtre);
%*******

else
   load('C:\Users\sam_p\OneDrive - ETS\PFE\Vision\Workspace (debugging)\31Jan2021.mat');
end


%Rotation de la zone de lettrage
%$$$À FAIRE$$$

%Traitement des zones de lettrage
[pictureGray] = zoneTextTraitement(pictureGray,Filtre);

%2-END


%SaveImage(pictureGray,SaveFile,ProgramFile);

