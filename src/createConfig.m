% /********************************************************************/
% /*                                                                  */
% /*  Plik createConfig.m                                             */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Plik przechowuj�cy ustawienia konfiguracyjne                */
% /*      umo�liwia �atwe modyfikowanie tych ustawien                 */
% /*      z jednego miejsca w programie                               */  
% /*      Dokladny opis przy poszczeg�lnych polach struktury          */
% /*                                                                  */
% /*                                                                  */
% /*  Autor:                                                          */
% /*      Grzegorz Caban, rok III AiR                                 */
% /*      Pawe� Gutowski, rok III AiR                                 */
% /*  Ostatnia modyfikacja:                                           */
% /*      3 stycznia 2007                                             */
% /*                                                                  */
% /********************************************************************/


%wstepne usuniecie wszystkich zmiennych z Workspace Matlaba maj�ce na celu
%oszczedzanie pamieci
close,clear all
%pobiera z pliku wzorce cyfr uzywanych pozniej do pisania na klatkach filmu            
load 'literki.mat';
%tutaj znajduje si� g��wna struktura przechowuj�ca parametry wykorzystywane
%w calym programie                                  
                                                    %pole okreslajace :
                                                                                
config = struct('file', 'akademik_1_no_compress.avi',...          %nazwe pliku ktora zostaje poddany analizie
                'outputFileName', 'output_test.avi',...  %tutaj podajemy nazwe 
                ...                                 %pliku do ktorego ma zostac zapisany wyjsciowy film
                'formatWyswietlania', 1, ...        %Flaga okreslajaca jakie rodzaje klatek maj� si� znale�� na filmie wyj�ciowym 
                ...                                 % 1 - [imgBinary imgGray ; imgSum imgSegmLabeled]
                ...                                 % 2 - [imgDiff imgNextDiff ; imgBinary imgNextBinary ; imgSum imgSegm]
                ...                                 % 3 - [imgGray imgSegmLabeled ]
                'p', 1,...                        %od ktorej klatki filmu chcemy zaczac analize
                'q' , 422,...                       %ktora klatka ma byc ostatnia poddana analizie
                'levelBack', 0.15,...                %tutaj ustawiamy prog binrazacji dla obrazu bedacego roznica aktualnej klatki i tla
                'levelPrev', 0.05,...                %tutaj ustawiamy prog binrazacji dla obrazu bedacego roznica dwoch kolejnych klatek
                'manualRect',1,...                  %ustawiamy wybor czesci obrazu ktora ma zostac poddana analizie :
                ...                                 %1 - chcemy recznie wyznaczyc obszar wskazujac go myszka przy uzyciu funkcji imcrop()
                'rect', [278,236,197,154],...         %2 - analizujemy tylko obszar mieszczacy sie w wspolrzednych zawartch w prostokacie 'rect' zawiera wspol�edne obszaru wybranego do analizy
                'generateStats',1,...               %czy chcemy wygenerowac dodatkowe statystyki na temat wartosci wspolczynnikow ksztaltu 
                ...                                 %1 -Tak 0 -nie
                'medSize', 12,...                   %wielkosc maski filtra medianowego uzywanej w wstepnej filtracji
                'min_rozmiar_babla',450,...        %minimalne pole obiektu konieczne aby nie zostal on uznany za zaklocenie
                ...                                 %tylko obiekty majace wieksze pole zostaja poddane analizie
                'dilatSize', 5,...                  %wielkosc maski dylatacji uzywanej do sklejania obiektow ktore przeszly przez
                ...                                 %tzn klopotliwe regiony
                'minAge', 10,...                     %minimalna ilo�� klatek na kt�re musi si� pojawi� cz�owiek aby przy znikni�ciu zosta� zliczony 
                ...                                 %Czyli je�eli obiekt pojawi si� na
                ...                                 %kr�cej ni� minAge klatek, zostaje uznany tylko za szum!   
                ...                                 % Ponizej wspolczynniki wagowe sluzace do obliczania sredniej klasyfikujacej 
                ...                                 %ile obiektow zawiera kazdy obiekt. 
                'wagaPrzenikania', 0.5,...          %istotnosc informacji pochodzacej z sledzenia obiektu
                'wagaKsztaltu', 0.25,...            %istotnosc informacji pochadzacej z ksztaltu obiektu
                'wagaPola', 0.25,...                %istotnosc informacji pochodzacej z pola obiektu
                ...                                 %Suma tych wag musi byc rowna 1!
                'BadSectors',0,...                  %czy powinnismy zajac sie badaniem rejonow ze szczegolna dokladnoscia
                'BadSectorsMinValue', 30,...        %okresla dolny prog luminancji 
                'BadSectorsMaxValue', 60,...        %okresla gorny prog luminancji
                ...                                 %znajduje sie  w niej wszystkie obszary ktorych wartosc luminancji,
                ...                                 %na pierwszej klatce filmu, znajduje sie w tym przedziale, 
                'progDwochOsob',1000,...            %wartosc pola od ktorej uznajemy dany obiekt za dwie osoby
                'progTrzechOsob',2500,...           %wartosc pola od ktorej uznajemy dany obiekt za trzy osoby
                'progCzterechOsob',3000);             %wartosc pola od ktorej uznajemy dany obiekt za cztery osoby
            