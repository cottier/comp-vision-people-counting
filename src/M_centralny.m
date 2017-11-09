function r = M_centralny(p,q,X)

% /********************************************************************/
% /*                                                                  */
% /*  M_centralny                                                     */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Oblicza moment centralny zadanego rzêdu                     */
% /*                                                                  */
% /*  Argumenty funkcji:                                              */
% /*        p - okresla rzad momentu zwyklego wzgledem zmienne x      */
% /*        q - okresla rzad momentu zwyklego wzgledem zmienne y      */
% /*        X - wejsciowy zbinaryzowany obraz obiektu                 */  
% /*                                                                  */
% /*  Funkcja zwraca:                                                 */
% /*      r - wartosc momentu                                         */
% /*                                                                  */
% /*  Uzywane funkcje:                                                */
% /*      m - funkcja obliczajaca moment zwykly                       */
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

rozm = size(X);
x = rozm(1);
y = rozm(2);

m_00 = m(0,0,X);
i_ = m(1,0,X) / m_00;   %centrum obrazu Y
j_ = m(0,1,X) / m_00;   %centrum obrazu X

r = 0;

for i = 1 : x
    for j = 1 : y
        r = r + (i-i_)^p * (j-j_)^q * X(i,j);
    end
end
