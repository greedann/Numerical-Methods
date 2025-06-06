function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego
% b - prawa granica przedziału poszukiwań miejsca zerowego
% max_iterations - maksymalna liczba iteracji działania metody bisekcji
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od xtab(1)= (a+b)/2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));

xsolution = [];
ysolution = [];
iterations = [];
xtab = [];
xdif = [];

if fun(a)*fun(b) > 0
    disp('Brak miejsca zerowego w zadanym przedziale');
    return;
end

for i = 1:max_iterations
    x = (a+b)/2;
    xtab = [xtab x];
    if i > 1
        xdif = [xdif abs(xtab(i-1)-xtab(i))];
    end
    if abs(fun(x)) < ytolerance
        xsolution = x;
        ysolution = fun(x);
        iterations = i;
        xtab = transpose(xtab);
        xdif = transpose(xdif);
        return;
    end
    if fun(a)*fun(x) < 0
        b = x;
    else
        a = x;
    end
end
end
