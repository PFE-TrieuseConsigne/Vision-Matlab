%Fonction qui permet d'identifier le mot "Québec" sur une cannette vue de
%haut

%Fonctionnement
%1- On aligne la canette avec le diamètre extérieur et le ? troue ?
%2- Sachant l'alignement, on isole les parties de droite et gauche où il est écrit "Québec" et "Consignable" 
%On effectue des traitements sur ces nouvelle zone pour mieux faire sortir
%les gravures
%3- 
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

%Variable que l'on peut modifier
nb_image = 1;
chemain_dossier = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\Picture_Bank\Picture_Test';

%load les photos dans un array, un en noir et blanc, l'autre en couleur
    [pictureGray,picture] = GetPicture(chemain_dossier);       
%Selectionne aléatoirement un nombre (nb_image) de photo pour affichage (pour le
%débuggage)
    [selectedPicture,pictureNumber] = SelectRandomPicture(nb_image,pictureGray);
%Affiche les images sélectionné aléatoirement
    %ShowWithSubPlot(selectedPicture,pictureNumber)     

    
%1-On aligne la canette avec le diamètre extérieur et le ? troue ?    
%Isolation du diamètre extérieur
seuilHF = 6;
seuilContrast = 45;
SeuilSelEtPoivre = 175000;

imageHF = FiltreFrequentiel(pictureGray,seuilHF);
[imageCercle,centreCercle,rayon] = IsolateCircle(imageHF,seuilContrast,SeuilSelEtPoivre);

%Enlève le fond (Background)
pictureGray = RemoveBackground(pictureGray,centreCercle,rayon);

%
pictureGray = RemoveMiddle(pictureGray,centreCercle,rayon);

%Isolation du troue
[imageOutput,monCentroide] = IsolateHole(pictureGray,40,centreCercle);

%1-END

%2- Sachant l'alignement, on isole les parties de droite et gauche où il est écrit "Québec" et "Consignable" 
%Isolation de la zone de lettrage
%$$$À FAIRE$$$

%Rotation de la zone de lettrage
%$$$À FAIRE$$$

%Rotation de la zone de lettrage
%$$$À FAIRE$$$

%Traitement des zones de lettrage
%$$$À FAIRE$$$

%2-END

%imshow(image{1},[]);

