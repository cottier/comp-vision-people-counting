%Generowanie map bitowych z cyferkami
%Raz wygenerowane literki s¹ wielorazowego u¿ytku, zatem
%wystarczy je wygenerowaæ tylko raz i umieœciæ np w pliku .mat!!!!
literki = createCharMaps('Helvetica', 14, 1, 1);


rysunek = zeros(200,200);


%liczby = [ 12 43243.5322 432432 432 0.4324343243 52342 ];
%liczby = liczby';
liczby = 12;
rysNapis = putNumsToImg( liczby , rysunek, 20, 20 , 2, literki,255);
imshow(rysNapis);