function X_wyj = putNumsToImg(liczby, X, wsp_x, wsp_y, mscPoPrzecinku, mapyCyferek, kolor)

maska = [];
iloscLiczb = size(liczby);
iloscLiczb = iloscLiczb(1);

for k = 1 : iloscLiczb
    
    napis = num2str(liczby(k));
    napis = napis';
    rozmiar = size(napis);
    dlugosc = rozmiar(1);
    poPrzecinku = 0;
    c = [];
    for i=1:dlugosc
        if poPrzecinku <= mscPoPrzecinku
            if napis(i) == '0'     c = [c mapyCyferek(10).Image];    end;
            if napis(i) == '1'     c = [c mapyCyferek(1).Image];    end;
            if napis(i) == '2'     c = [c mapyCyferek(2).Image];    end;
            if napis(i) == '3'     c = [c mapyCyferek(3).Image];    end;
            if napis(i) == '4'     c = [c mapyCyferek(4).Image];    end;
            if napis(i) == '5'     c = [c mapyCyferek(5).Image];    end;
            if napis(i) == '6'     c = [c mapyCyferek(6).Image];    end;
            if napis(i) == '7'     c = [c mapyCyferek(7).Image];    end;
            if napis(i) == '8'     c = [c mapyCyferek(8).Image];    end;
            if napis(i) == '9'     c = [c mapyCyferek(9).Image];    end;

            if poPrzecinku > 0
                poPrzecinku = poPrzecinku + 1;
            end;        
        
            if napis(i) == '.'     
                c = [c mapyCyferek(11).Image]; 
                poPrzecinku = 1;
            end;
        end;
    end;
    szerStarego = size(maska);
    szerStarego = szerStarego(2);
    szerNowego = size(c);
    szerNowego = szerNowego(2);
    
    wysStarego = size(maska);
    wysStarego = wysStarego(1);
    wysNowego = size(c);
    wysNowego = wysNowego(1);
    
    if szerStarego >= szerNowego
        maska = [maska ; c zeros(wysNowego, szerStarego-szerNowego)];
    else
        maska = [maska  zeros(wysStarego, szerNowego-szerStarego) ; c ];
    end;
end;

% Determine where the text was (black is 0):
[i,j] = find(maska == 1);

% Index into new image, replacing pixels with white:
rozm = size(X);
szer = rozm(1,1);
wys = rozm(1,2);

X_wyj = X;
dlugosc = size(i);
n = dlugosc(1,1);
for k = 1 : n
    if (int16(wsp_x) + i(k,1) < szer) && (int16(wsp_y) + j(k,1) < wys) 
        X_wyj( int16(wsp_x) + i(k,1) , int16(wsp_y) + j(k,1) ) = uint8(kolor);
    end
end