function [image_Output] = FiltreFrequentiel(image,seuil)
%UNTITLED Summary of this function goes here
%Filtre Passe-Haut pour faire ressortir les contours
%   Detailed explanation goes here

for i = 1:length(image)
%figure(2),imshow(image{i});
F = fftshift(fft2(image{i}));
%figure(i+99),imshow(log(abs(F)+1),[]);
[M,N,~] = size(image{i});

%H = Masque
[v,u]=meshgrid(1:N,1:M);
H = double(sqrt((u-M/2).^2+(v-N/2).^2)) < seuil;
H= ~H;
%figure(3),imshow(H);
G = F.*H;
image_Output{i} = real(ifft2(fftshift(G)));
%figure(1),imshow(uint8(image_Output{i}),[]);
end



end

