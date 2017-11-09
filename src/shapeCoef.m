function [rW7,rArea] = shapeCoef(grain, config)

% /********************************************************************/
% /*                                                                  */
% /*  shapeCoef                                                       */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Funkcja shapeCoef okresla ile osob reprezentuje dany obiekt */
% /*      otrzymany z segmentacji.                                    */
% /*                                                                  */
% /*                                                                  */
% /*  Argumenty funkcji:                                              */
% /*      struct grain - jest to Matlabowska struktura zwrocona       */
% /*      przez funkcje regionprops() zawierajaca wybrane informacje  */
% /*      na temat kazdego znalezionego obiektu                       */
% /*                                                                  */
% /*  Funkcja zwraca:                                                 */
% /*      int rW7 - jest to ilosc osob bedaca w danym obiekcie        */
% /*      na podstawie wspolczynnika ksztaltu W7                      */
% /*      int rArea - jest to ilosc osob bedaca w danym obiekcie      */
% /*      na podstawie pola danego obiektu                            */
% /*                                                                  */
% /*  Uzywane funkcje:                                                */
% /*      W7 - funkcja obliczajaca wspolczynnik W7                    */
% /*                                                                  */
% /*                                                                  */
% /*                                                                  */
% /*  Autor:                                                          */
% /*      Grzegorz Caban, rok III AiR                                 */
% /*                                                                  */
% /*  Ostatnia modyfikacja:                                           */
% /*      15 grudnia 2006                                             */
% /*                                                                  */
% /********************************************************************/



w7 = W7(grain.Image);
Area = grain.Area;
numW7 = 0;
numArea = 0;

if double(w7) < double(0.1)
    numW7 = 2;
else
    numW7 = 1;
end    

if (Area > config.min_rozmiar_babla) & (Area < config.progDwochOsob)
    numArea = 1;
end

if (Area > config.progDwochOsob) & (Area < config.progTrzechOsob)
    numArea = 2;
end

if (Area > config.progTrzechOsob) & (Area < config.progCzterechOsob)
    numArea = 3;
end
if (Area > config.progCzterechOsob) 
    numArea = 4;
end


rW7 = numW7;
rArea = numArea;