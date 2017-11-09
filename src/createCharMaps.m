%tworzy mapy dla kazdej z 10 cyfr i przecinka
%size - rozmiar czcionki
%letterSpacing - przerwa miêdzy cyferkami
%rowSpacing - przerwa miêdzy wierszami

function R = createCharMaps(font, size, letterSpacing, rowSpacing)
% Create the text in an axis:
figure('Position',[10 10 1000 300]);
napis = '1234567890,';
t = text(.05,.8, napis, ...
         'FontSize', size, ...
         'FontName' , font, ...
         'FontWeight','demi');

% Capture the text from the screen:
F = getframe(gca,[30 150 350 80]);

% Close the figure:
close

% Select any plane of the resulting RGB image:
c = F.cdata(:,:,1);
c = im2bw( c , 0.5 );       %binaryzacja
c = 1 - c;

[imgSegm,numObjects] = bwlabel(c,4);               %segmentacja
graindata = regionprops(imgSegm, 'Area', 'Image', 'PixelList', 'BoundingBox');
imgSegm = label2rgb(imgSegm, @gray, 'c', 'shuffle');    %przpisanie kolorkow
imgSegm = rgb2gray(imgSegm);                              %konwersja do skali szarosci


%przeskalowujemy przecinek
nadPrzecinkiem = graindata(11).BoundingBox(2) - graindata(1).BoundingBox(2) %tyle wierszy musimy dodaæ nad przecinkiem
szerPrzecinka = graindata(11).BoundingBox(3) + letterSpacing
wysPrzecinka = graindata(11).BoundingBox(4)
graindata(11).Image = [zeros(nadPrzecinkiem,szerPrzecinka) ; ...
    graindata(11).Image zeros(wysPrzecinka, letterSpacing); ...
    zeros(rowSpacing,szerPrzecinka)];

R = struct('Image', []);
for i=1:10
    podCyferka = graindata(11).BoundingBox(2) + graindata(11).BoundingBox(4) - graindata(i).BoundingBox(2) - graindata(i).BoundingBox(4)+ rowSpacing %tyle wierszy musimy dodaæ pod kazda cyferk¹
    szerCyferki = graindata(i).BoundingBox(3) + letterSpacing
    wysCyferki = graindata(i).BoundingBox(4)
    graindata(i).Image = [ graindata(i).Image zeros(wysCyferki,letterSpacing); ...
        zeros(podCyferka,szerCyferki) ];

    R(i) = struct('Image', graindata(i).Image);
end
R(11) = struct('Image', graindata(11).Image);

