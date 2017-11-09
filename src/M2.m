function r = M2(X)

% /********************************************************************/
% /*                                                                  */
% /*  M2                                                              */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Oblicza moment M2                                           */
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
M11 = M_centralny(1,1,X);
m_00 = m(0,0,X);

r = (( M20 - M02 )^2 + 4*M11^2 ) / m_00^4;
