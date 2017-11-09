function r = M3(X)

% /********************************************************************/
% /*                                                                  */
% /*  M3                                                              */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Oblicza moment M3                                           */
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

M30 = M_centralny(3,0,X);
M12 = M_centralny(1,2,X);
M21 = M_centralny(2,1,X);
M03 = M_centralny(0,3,X);
m_00 = m(0,0,X);

r = (( M30 - 3*M12 )^2 + (3*M21-M03)^2 ) / m_00^5;
