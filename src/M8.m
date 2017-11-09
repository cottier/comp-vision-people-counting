function r = M8(X)

% /********************************************************************/
% /*                                                                  */
% /*  M8                                                              */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Oblicza moment M8                                           */
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

r = ( M30*M12 + M21*M03 - M12^2 -M21^2 ) / m_00^5;
