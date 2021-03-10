%Fonction qui permet d'entrainer un réseau de classification d'image

%Load le réseau pré-entrainer AlexNet
net = alexnet; 
layers = net.Layers;


rootFolder = 'C:\Users\sam_p\OneDrive - ETS\PFE\Vision\PictureDataNetwork\TrainingData';
%Liste des catégories, on peut rajouter des catégories de plus selon le
%nombre de fichier dans rootFolder
categories = {'AvecDroite','AvecGauche','SansDroite','SansGauche'};
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');

%On entraine avec 70% et en test avec 30% des images
[imds,testDS] = splitEachLabel(imds, 0.7, 'randomize'); % we only need 500 images per class
imds.ReadFcn = @readFunctionTrain;
%On convertie gray to rgb avec augmentedImageDatastore puisque Alexnet
%prend des images de  227 x 227 x 3 et non  227 x 227 x 1  
auimds = augmentedImageDatastore([227,227],imds,'ColorPreprocessing','gray2rgb');
autestDS = augmentedImageDatastore([227,227],testDS,'ColorPreprocessing','gray2rgb');


layers = layers(1:end-3);

layers(end+1) = fullyConnectedLayer(64, 'Name', 'special_2');
layers(end+1) = reluLayer;
layers(end+1) = fullyConnectedLayer(4, 'Name', 'fc8_2 ');
layers(end+1) = softmaxLayer;
layers(end+1) = classificationLayer();

layers(end-2).WeightLearnRateFactor = 10;
layers(end-2).WeightL2Factor = 1;
layers(end-2).BiasLearnRateFactor = 20;
layers(end-2).BiasL2Factor = 0;

%Training option:
opts = trainingOptions('sgdm', ...
    'LearnRateSchedule', 'none',...
    'InitialLearnRate', .0001,... 
    'MaxEpochs', 20, ...
    'MiniBatchSize', 128);


convnet = trainNetwork(auimds, layers, opts);


%Test
[labels,err_test] = classify(convnet, autestDS);

%***On affiche 10 images sélectionné aléatoirement
numberArray = 1:length(labels);
numInspect = 10;
if numInspect < length(labels)
for i = 1 : numInspect
num = uint8(rand * (length(numberArray)-1))+1;
if ismember(num,numberArray)
    if num ~=1
        FirstPart = numberArray(1:(num)-1);
        SecondPart = numberArray(num+1:length(numberArray));
        clear numberArray
        numberArray = [FirstPart SecondPart];   
    elseif num == 1
        SecondPart = numberArray(num+1:length(numberArray));
        clear numberArray
        numberArray = SecondPart;
    end
end

figure(i),
subplot(1,1,1),imshow(autestDS.Files{num}), title(['Label',strrep(cellstr(labels(num)),'_','-'),'Confiance :',num2str(max(err_test(num,:)))]);
end
%***END 

clear FirstPart
clear SecondPart
clear numberArray
end
%On calcule les résultats du réseau
confMat = confusionmat(testDS.Labels, labels);
confMat = confMat./sum(confMat,2);
mean(diag(confMat))
