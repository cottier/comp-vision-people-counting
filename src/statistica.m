function r = statistica(dataTable)

% /********************************************************************/
% /*                                                                  */
% /*  statistica                                                      */
% /*                                                                  */
% /*  Przeznaczenie:                                                  */
% /*      Funkcja statistica oblicza wszystkie wartosci momentow      */
% /*      geometrycznych oraz wspolczynnikow ksztaltu                 */
% /*      i zapisuje je w wygodnej do pozniejszej analizy strukturze  */
% /*                                                                  */
% /*  Argumenty funkcji:                                              */
% /*      dataTable - jest to structura przechowujaca dane o kazdym   */
% /*      obiekcie wykrytym na kazdej klatce analizowanego filmu      */
% /*                                                                  */
% /*  Funkcja zwraca:                                                 */
% /*      int r                                                       */
% /*                                                                  */
% /*  Uzywane funkcje:                                                */
% /*            M_centralny.m   - oblicza moment centralny
% /*            m.m - oblicza moment zwykly 
% /*            M1.m - oblicza moment M1
% /*            M2.m
% /*            M3.m
% /*            M4.m
% /*            M7.m
% /*            M8.m
% /*            W3.m - oblicza wspolczynnik ksztaltu W7
% /*            W7.m
% /*                                                                  */
% /*                                                                  */
% /*                                                                  */
% /*  Autor:                                                          */
% /*      Grzegorz Caban, rok III AiR                                 */
% /*                                                                  */
% /*  Ostatnia modyfikacja:                                           */
% /*      17 grudnia 2006                                             */
% /*                                                                  */
% /********************************************************************/

Area = [];
dataM1 = [];
dataM2 = [];
dataM3 = [];
dataM4 = [];
dataM7 = [];
dataM8 = [];
dataW3 = [];
dataW7 = [];
for i = 1 :length(dataTable)
    for j = 1:length(dataTable(i).Tab)
        Area(i,j) = dataTable(i,1).Tab(j,1).Area;
        dataM1(i,j) = M1(dataTable(i).Tab(j).Image);
        dataM2(i,j) = M2(dataTable(i).Tab(j).Image);
        dataM3(i,j) = M3(dataTable(i).Tab(j).Image);
        dataM4(i,j) = M4(dataTable(i).Tab(j).Image);
        dataM7(i,j) = M7(dataTable(i).Tab(j).Image);
        dataM8(i,j) = M8(dataTable(i).Tab(j).Image);
        dataW3(i,j) = W3(dataTable(i).Tab(j).Image, dataTable(i).Tab(j).Area);
        dataW7(i,j) = W7(dataTable(i).Tab(j).Image);
        
    end
end
data = struct(  'Area', Area,...
                'M1', dataM1,...
                'M2', dataM2,...
                'M3',dataM3,...
                'M4',dataM4,...
                'M7',dataM7,...
                'M8',dataM8,...
                'W3',dataW3,...
                'W7',dataW7);
r = data;