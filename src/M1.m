function r = M1(X)

% /********************************************************************/
% /*                                                                  */
% /*  M1                                                              */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Oblicza moment M1                                           */
% /*                                                                  */
% /*  Argumenty funkcji:                                              */
% /*        X - wejsciowy zbinaryzowany obraz obiektu                 */  
% /*                                                                  */
% /*  Funkcja zwraca:                                                 */
% /*      r - wartosc momentu                                         */
% /*                                                                  */
% /*  Uzywane funkcje:                                                */
% /*      m - funkcja obliczajaca moment zwykly                       */
% /*      M_centralny - funkcja obliczajaca moment centralny          */
% /*                                                                  */
% /*                                                                  */
% /*                                                                  */
% /*  Autor:                                                          */
% /*      Pawel Gutowski, rok III AiR                                 */
% /*                                                                  */
% /*  Ostatnia modyfikacja:                                           */
% /*      15 grudnia 2006                                             */
% /*                                                                  */
% /********************************************************************/

M20 = M_centralny(2,0,X);
M02 = M_centralny(0,2,X);
m00 = m(0,0,X)

r = (M20 + M02)/m00^2
