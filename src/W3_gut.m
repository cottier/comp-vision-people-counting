%Malinowska
function Malinowska = W3(X)

%liczymy pole
[i,j] = find(X == 1);
S = length(i);

%liczymy obwod
img_perim = bwperim(X);
[i,j] = find(img_perim == 1);
L = length(i);

Malinowska = L / ( 2 * sqrt(pi*S) ) - 1;
