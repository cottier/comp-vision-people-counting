
function r = W7(X)

% /********************************************************************/
% /*                                                                  */
% /*  W7                                                              */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Oblicza wspolczynnik W7                                     */
% /*                                                                  */
% /*  Argumenty funkcji:                                              */
% /*        X - wejsciowy zbinaryzowany obraz obiektu                 */  
% /*                                                                  */
% /*  Funkcja zwraca:                                                 */
% /*      r - wartosc W3                                              */
% /*                                                                  */
% /*                                                                  */
% /*                                                                  */
% /*                                                                  */
% /*  Autor:                                                          */
% /*      Pawel Gutowski, rok III AiR                                 */
% /*                                                                  */
% /*  Ostatnia modyfikacja:                                           */
% /*      15 listopada 2006                                           */
% /*                                                                  */
% /********************************************************************/

[Segm,numObjects] = bwlabel(X,4);               %wiem, ze nie powinienem po raz drugi robic calej segmentacji, ale nie chcialo mi sie tego ladniej naisac
graindata = regionprops(Segm, 'Centroid');
sr_masy = graindata(1).Centroid;
x_masa = sr_masy(1,1);
y_masa = sr_masy(1,2);

%liczymy obwod
img_perim = bwperim(X);
[i,j] = find(img_perim == 1);
L = length(i);

r_min = 1000;
R_max = 0.0001;

for k = 1:L
    d = sqrt( ( i(k)-x_masa )^2 + ( j(k)-y_masa )^2 );
    
    if d < r_min
        r_min = d;
    end
    
    if d > R_max
        R_max = d;
    end
end

r = r_min / R_max;




