close,clear all
            
load 'literki.mat';
config = struct('file', 'c3_2_uncompressed.avi',...
                'outputFileName', 'c3_2_output.avi',...
                'formatWyswietlania', 3, ...        %Flaga okreslajaca jakie rodzaje klatek maj� si� znale�� na filmie wyj�ciowym 
                ...                                 % 1 - 
                'p', 1,... 
                'q' , 6860,...                                   
                'levelBack', 0.15,...
                'levelPrev', 0.1,...
                'manualRect',0,...
                'generateStats',0,...          %generuje statystyki
                'rect', [31,17,272,223],...
                'medSize', 12,...
                'min_rozmiar_babla',1500,... 
                'dilatSize', 25,...
                'minAge', 4,...         %minimalna ilo�� klatek na kt�re musi si� pojawi� cz�owiek aby przy znikni�ciu zosta� zliczony 
                ...                     %Czyli je�eli obiekt pojawi si� na
                ...                     %kr�cej ni� minAge klatek, zostaje uznany tylko za szum!                                         
                'wagaPrzenikania', 0.5,...
                'wagaKsztaltu', 0.25,...
                'BadSectors',1,...      %okresla czy pownnismy zajac sie badaniem niektorych rejonow ze szczegolna dokladnoscia
                'BadSectorsMinValue', 30,...
                'BadSectorsMaxValue', 60,...
                'wagaPola', 0.25,...
                'progDwochOsob',6200,...            %wartosc pola od ktorej uznajemy dany obiekt za dwie osoby
                'progTrzechOsob',13000,...           %wartosc pola od ktorej uznajemy dany obiekt za trzy osoby
                'progCzterechOsob',20000);             %wartosc pola od ktorej uznajemy dany obiekt za cztery osoby); 
                