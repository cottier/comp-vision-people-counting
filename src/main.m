% /********************************************************************/
% /*                                                                  */
% /*  G��wny skrypt programu MAIN_CAB                                 */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Jest to g��wna procedura programu, z jej                    */
% /*      wnetrza uruchamiane sa pozostale moduly                     */
% /*                                                                  */
% /*  Uzywane funkcje:                                                */
% /*
% /*    Funkcje z Matlab Image Processing Toolbox:
% /*    roicolor()
% /*    imcrop()
% /*    aviinfo()
% /*    avifile()
% /*    aviread()
% /*    regionprops()
% /*    bwlabel()
% /*    rgb2gray()
% /*    imdilate()
% /*    strel()
% /*    immultiply()
% /*    imabsdiff()
% /*    im2bw()
% /*    im2frame()
% /*    Wlasne funckje : 
% /*    progressBar()  - funkcja rysujaca progress bar
% /*    putNumsToImg() - funkcja wypisujaca cyfry na obrazie
% /*    blobTracker()  - implementuje algorytm sledzenia
% /*    statistica()   - oblicza i zapisuje wartosci wszystkich
% /*        wspolczynnikow ksztaltu i momentow geometrycznych dla kazdego 
% /*        obietktu z kazdej klatki filmu 
% /*
% /*
% /*
% /*
% /*
% /*                                                                  */
% /*  Uzywane zmienne:                                                */
% /*    config - Skrypt main korzysta z zmiennej config,              */
% /*      tworzonej przez skrypt config_cab. Konieczne jest           */
% /*      poprawne zaincjowanie wszystkich pol struktury config.      */
% /*      Wszystkie pola struktury sa opisane dokladnie w pliku       */
% /*      config_cab.m                                                */
% /*
% /*    LICZNIK_LUDZI - zmienna przechowujaca zliczana                */
% /*      ludzi ilosc                                                 */
% /*
% /*    God - tablica struktur przechowujaca dane z kazdej klatki     */
% /*      na temat wszystkich obiektow wykrytych w tej klatce         */
% /* 
% /*    outputFileMovie - przechowuje uchwyt do pliku wyjsciowego
% /*
% /*    Zmienne przechowujace kolejne, przetworzone klatki obrazu:
% /*    background - przechowuje obraz t�a (pierwsza klatke)
% /*    tmpFrame - przechowuje aktualna klatke filmu
% /*    imgGray - konwertuje klatke filmu z RGB do skali szarosci
% /*    imgDiff - zawiera obraz roznicowy klatki aktualnej i tla
% /*    imgBinary - zawiera zbinaryzowany obraz imgDiff
% 
% /*    Dodatkowy klatki potrzebne do sklejania obietkow nalezacych do
% /*    Maski Klopotliwych Obszarow
% /*    maskaKlopotliwychObszarow - zawiera piksele ktorych luminancja
% /*      miesci sie w pewnym okreslonym przez uzytkownika przedziale
% /*    imgDilatated - przechowuje obraz po dylatacji
% /*    imgWyciete - zawiera tylko te obszary z imgDilatated ktore naleza
% /*        jednoczesnie do maskaKlopotliwychObszarow
% /*    imgReparatedDiff - obraz koncowy po dodaniu imgWyciete do
% /*        poczatkowego obrazu imgBinary
% /*    imgNextDiff - obraz bedacy roznica dwoch kolejnych klatek
% /*    imgNextBinary - zbinaryzowany imgNextDiff
% /*    imgSum - obraz bedacy suma logiczna obrazow imgNextBinary i
% /*    imgBinary
% /*    imgSegm - obraz img Sum po segmentacji funkcja bwlabel 
% /*    numObjects - ilosc znalezionych na klatce obiektow
% /*    graindata - tablica struktur przechowujaca dane otrzymane z
% /*        funkcji regionprops()
% /*    imgMesh - obraz imgSegm po usunieciu obiektow o polu mniejszym niz
% /*        zadany prog
% /*    imgSegmLabeled - obraz po segmentacji na ktory wpisujemy wartosci
% /*        wspolczynnikow takich jak ilosc osob itp.
% /*    imgFinal - koncowy obraz bedacy zlozeniem wybranych przez
% /*        uzytkownika klatek 
% /*    prevGraindata - zmienna przechowujaca tablice graindata z
% /*        poprzedniej iteracji glownej petli, umozliwia to porownie tych
% /*        informacji z dwoch kolejnych klatkach co jest konieczne w  
% /*        algorytmie sledzenia 
% /*    prevImgSegm - przechowywany obraz po segmentacji z poprzedniej
% /*        klatki, rowniez konieczne przy segmentacji
% /*    Stats - struktura przechowujaca wyliczone wartosci wszystkich
% /*        wspolczynnikow ksztaltu i momentow geometrycznych dla kazdego obietktu z
% /*        kazdej klatki filmu
% /*    cyferki - wektor przechowujacy liczby ktore zostana zapisane na
% /*        klatce
% /*
% /*
% /* 
% /*  Uwagi:                                                          */
% /*      Pliki konieczne do uruchomienia tego skryptu.               */
% /*        config_cab.m
% /*        shapeCoef.m
% /*        progressBar.m
% /*        putNumsToImg.m
% /*        M_centralny.m
% /*        W7.m
% /*        perimeter.m
% /*        literki.mat
% /*        statistica.m
% /*        M1.m
% /*        M2.m
% /*        M3.m
% /*        M4.m
% /*        M7.m
% /*        M8.m
% /*        W3.m
% /*        m.m 
% /*                                                                  */
% /*  Autor:                                                          */
% /*      Grzegorz Caban, rok III AiR                                 */
% /*      Pawe� Gutowski, rok III AiR                                 */
% /*                                                                  */
% /*  Ostatnia modyfikacja:                                           */
% /*       5 stycznia 2007                                            */
% /*                                                                  */
% /********************************************************************/

%odpalenie skryptu inicjalizuj�cego kluczow� strukture config przechowuj�c�
%parametry konfiguracyjne
createConfig;
%pobieranie informacji o wejsciowym pliku filmowym
info = aviinfo(config.file);
n = info.NumFrames;
%ustawienie nazwy i kompresji pliku z filmem wyjsciowym 
outputFileMovie = avifile(config.outputFileName,'compression','none');
%pobranie pierwszej klatki filmu
tmpFrame = aviread(config.file,1);
imgGray = rgb2gray(tmpFrame.cdata);
%sprawdza czy powinien zapytac uzytkownika o wybor regionu analizy na
%pierwszej klatce
if config.manualRect == 1
   [imgGray,config.rect] = imcrop(imgGray);
else
% czy tez ma on byc automatycznie pobrany z zmiennej config.rect
   config.rect;
   imgGray = imcrop(imgGray,config.rect);
end;

background = imgGray;                       %zapisuje pierwsza klatke filmu jako tlo

% W niekt�rych filmach pojawi� si� problem:
% Film by� zbyt ciemny i fragmenty t�a mia�y kolor zblizony do wi�kszo�ci
% obiekt�w, kt�re nale�a�o wykry�
% W tym celu tworzymy tzw. Maske K�opotliwych Obszar�w pokrywaj�c� si� z tymi fragmentami, po to, aby
% poprzez dylatacj� 'odtworzy�' te zgubione fragmenty obiekt�w
if config.BadSectors == 1
    maskaKlopotliwychObszarow = roicolor(background, config.BadSectorsMinValue,config.BadSectorsMaxValue);    
end

graymap = colormap(gray(256));
%inicjalizujemy glowna zmienna przechwujaca dane na temat wszystkich
%wykrytych obiektow
God = [];
%zmienna w ktorej zliczamy ilosc ludzi
LICZNIK_LUDZI = 0;

%glowna petla programu iterujaca po wszystkich klatkach filmu z zadanego
%przez uzytkownika przedzialu (p,q)
for i = config.p:config.q
    progressBar(i-config.p+1,config.q-config.p+1)
    prevImg = imgGray;
    
    tmpFrame = aviread(config.file,i);         %czytanie z pliku
    
    img = imcrop(tmpFrame.cdata,config.rect);             %wyciecie interesujacej nas czesci obrazka

    
    imgGray = rgb2gray(img);                 %konwersja obrazu do skali szaro�ci

    imgDiff = imabsdiff( imgGray , background); %r�znica obraz�w

    imgBinary = im2bw(imgDiff,config.levelBack);       %binaryzacja
    imgBinary = im2uint8(imgBinary);
    %obsluga klopotliwych obszarow na obrazie
    if config.BadSectors == 1
        imgBinary = medfilt2(imgBinary, [config.medSize config.medSize]);
        SE = strel('disk',config.dilatSize);
        imgDilatated = imdilate(imgBinary, SE);
        imgWyciete = immultiply(imgDilatated, maskaKlopotliwychObszarow);
        imgWyciete = uint8(imgWyciete);
        imgReparatedDiff = imadd(imgBinary,imgWyciete);
        imgReparatedDiff = uint8(imgReparatedDiff);
    else
        imgReparatedDiff = imgBinary;
    end
    
    
    imgNextDiff = imabsdiff(imgGray, prevImg);

    imgNextBinary = im2bw(imgNextDiff,config.levelPrev);       %binaryzacja
    imgNextBinary = im2uint8(imgNextBinary);
    
    imgSum = imadd(imgNextBinary, imgReparatedDiff);
    imgSum = im2uint8(imgSum);
    
    imgMesh = medfilt2(imgSum, [config.medSize config.medSize]);
    
%------ Tu sie zaczyna zabawa z segmentacja   
    [imgSegm,numObjects] = bwlabel(imgMesh,4);               %segmentacja
    graindata = regionprops(imgSegm, 'Area', 'PixelList');
    for k = 1:numObjects
        %na obrazie wynikowym zostawiamy tylko obiekty o polu powyzej
        %pewnego zadanej wartosci pola
        if graindata(k).Area < config.min_rozmiar_babla
            lista = graindata(k).PixelList;
            len = size(lista);
            len = len(1,1);
            for z = 1:len
                imgMesh(lista(z,2), lista(z,1)) = 0;
            end
        end
    end
    
    [imgSegm,numObjects] = bwlabel(imgMesh,4);               %segmentacja po raz drugi
    graindata = regionprops(imgSegm, 'Area', 'Centroid', 'BoundingBox', 'Image', 'PixelList');
    
    imgSegm = label2rgb(imgSegm, @gray, 'c', 'shuffle');    %przypisanie kolorkow                    
    imgSegm = rgb2gray(imgSegm);                              %konwersja do skali szarosci
    imgSegmLabeled = imgSegm;
    
    if i > config.p
        %klatka druga i kolejne 
        %uruchamiamy algorytm sledzenia
        [graindata, dieingBubbles] = blobTracker( imgSegm, prevImgSegm, graindata, prevGraindata,  config);
        LICZNIK_LUDZI = LICZNIK_LUDZI + dieingBubbles;
        res = struct('Frame',i,'Tab', graindata);
        God = [God; res ];    

    else    %pierwsza klatka
        tab = [];
        for k = 1:numObjects
            [numS,numA] = shapeCoef(graindata(k), config);
            graindata(k).PrevID = [];
            graindata(k).numOfPeople = double(1);
            graindata(k).numOfPeopleShape = numS;
            graindata(k).numOfPeopleArea = numA;
            graindata(k).AverageNumOfPeopleShape = numS;
            graindata(k).AverageNumOfPeopleArea = numA;
            graindata(k).age = double(1);
            graindata(k).AverageCnt = 1;
            
            id = k;
            prevId = 0;
            
            %utworzenie tablicy zawierajacej dane o kazdym obiekcie z pierwszej klatki 
            tab = [tab; struct( 'ID',id,...
                        'PrevID',prevId,...
                        'NumOfPeople',graindata(k).numOfPeople,...
                        'numOfPeopleShape', numS,...
                        'numOfPeopleArea',numA,...
                        'Center',graindata(k).Centroid,...
                        'Image', graindata(k).Image,...
                        'Area',graindata(k).Area, ...
                        'AverageNumOfPeopleShape', numS, ...
                        'AverageNumOfPeopleArea', numA, ...
                        'AverageCnt', 1)];       %kolejne wywolanie blobTrackera bedzie w klatce drugiej wiec liczenie sredniej musi sie odbyc z dwoch klatek
        end
        A = struct('Frame',i,'Tab', tab);    
        God = [God; A];    
    end
    %wypisanie wartosci liczbowych przy wszystkich obiektach wykrytych na
    %obrazie
    for z=1:numObjects
        xy = graindata(z).Centroid;
        x = xy(2);
        y = xy(1);
        %tworzenie wektora cyfr ktore zostana wypisane na obrazie
        cyferki = [graindata(z).numOfPeople; God(i-config.p+1,1).Tab(z,1).numOfPeopleShape; God(i-config.p+1,1).Tab(z,1).numOfPeopleArea];

        imgSegmLabeled = putNumsToImg( cyferki , ...
            imgSegmLabeled, ...
            x, ...
            y, ...
            2, ...
            literki, ...
            80);
    end
    
    prevGraindata = graindata;
    prevImgSegm = imgSegm; 
   
%-------sklejanie poszczeg�lnych etap�w przetwarzania klatek w du�� klatk� ko�cow�
   switch config.formatWyswietlania
   case 1
      imgFinal = [imgBinary imgGray ; imgSum imgSegmLabeled];
   case 2
      imgFinal = [imgDiff   imgBinary imgSum imgGray;imgNextDiff imgNextBinary imgMesh   imgSegm];
   case 3
      imgFinal = [imgGray imgSegmLabeled ];
   otherwise
   end
   %naniesienie ilosci zliczonych osob na obraz
   imgFinal = putNumsToImg( LICZNIK_LUDZI, imgFinal, 0, 0, 6, literki, 255);
   frame = im2frame(imgFinal,graymap); 
   %dodanie klatki do koncowego filmu
   outputFileMovie = addframe(outputFileMovie,frame);
end
if config.generateStats == 1
    %wygenerowanie statystyk
    Stats = statistica(God);
    A = Stats.Area;
    M1 = Stats.M1;
    M2 = Stats.M2;
    M3 = Stats.M3;
    M4 = Stats.M4;
    M7 = Stats.M7;
    M8 = Stats.M8;
    W3 = Stats.W3;
    W7 = Stats.W7;
end
outputFileMovie = close(outputFileMovie);
