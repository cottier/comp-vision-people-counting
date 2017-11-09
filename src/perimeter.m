function r = perimeter(X)

% /********************************************************************/
% /*                                                                  */
% /*  perimeter                                                       */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Oblicza obwod danego obiektu                                */
% /*                                                                  */
% /*  Argumenty funkcji:                                              */
% /*        X - wejsciowy zbinaryzowany obraz obiektu                 */  
% /*                                                                  */
% /*  Funkcja zwraca:                                                 */
% /*      r - wartosc obwodu                                          */
% /*                                                                  */
% /*  Uzywane funkcje:                                                */
% /*      bwboundaries - zwraca wspolrzedne puntow na krawedzi obrazu */
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

B = bwboundaries(X, 'noholes');

P = 0;
B = B{1};
x = B(:,1);
y = B(:,2);
for i = 2:length(x)
    P = P + ((x(i)-x(i-1))^2 + (y(i) - y(i-1))^2)^0.5;
end
r = P;