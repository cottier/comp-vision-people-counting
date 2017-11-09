function r = m(p,q,X)

% /********************************************************************/
% /*                                                                  */
% /*  m                                                               */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Oblicza moment geometryczny zadanego rzêdu                  */
% /*                                                                  */
% /*                                                                  */
% /*  Argumenty funkcji:                                              */
% /*        p - okresla rzad momentu zwyklego wzgledem zmienne x      */
% /*        q - okresla rzad momentu zwyklego wzgledem zmienne y      */
% /*        X - wejsciowy zbinaryzowany obraz obiektu                 */  
% /*                                                                  */
% /*  Funkcja zwraca:                                                 */
% /*      r - wartosc momentu                                         */
% /*                                                                  */
% /*                                                                  */
% /*  Autor:                                                          */
% /*      Pawel Gutowski, rok III AiR                                 */
% /*                                                                  */
% /*  Ostatnia modyfikacja:                                           */
% /*      15 grudnia 2006                                             */
% /*                                                                  */
% /********************************************************************/

rozm = size(X);
x = rozm(1);
y = rozm(2);
r = 0;

for i = 1 : x
    for j = 1 : y
        r = r + i^p * j^q * X(i,j);
    end
end