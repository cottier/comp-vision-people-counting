function r= W3(X,S)
% /********************************************************************/
% /*                                                                  */
% /*  W3                                                              */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Oblicza wspolczynnik W3 Malinowskiej                        */
% /*                                                                  */
% /*  Argumenty funkcji:                                              */
% /*        X - wejsciowy zbinaryzowany obraz obiektu                 */  
% /*                                                                  */
% /*  Funkcja zwraca:                                                 */
% /*      r - wartosc W3                                              */
% /*                                                                  */
% /*  Uzywane funkcje:                                                */
% /*      perimeter - oblicza dluosc obwodu danego obiektu            */
% /*                                                                  */
% /*                                                                  */
% /*                                                                  */
% /*  Autor:                                                          */
% /*      Grzegorz Caban, rok III AiR                                 */
% /*                                                                  */
% /*  Ostatnia modyfikacja:                                           */
% /*      15 listopada 2006                                           */
% /*                                                                  */
% /********************************************************************/

r = perimeter(X)/(2*sqrt(pi*S));