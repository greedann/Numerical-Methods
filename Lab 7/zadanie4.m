function [integration_error, Nt, ft_5, xr, yr, yrmax] = zadanie4()
% Numeryczne całkowanie metodą Monte Carlo.
%
%   integration_error - wektor wierszowy. Każdy element integration_error(1,i)
%       zawiera błąd całkowania obliczony dla liczby losowań równej Nt(1,i).
%       Zakładając, że obliczona wartość całki dla Nt(1,i) próbek wynosi
%       integration_result, błąd jest definiowany jako:
%       integration_error(1,i) = abs(integration_result - reference_value),
%       gdzie reference_value to wartość referencyjna całki.
%
%   Nt - wektor wierszowy zawierający liczby losowań, dla których obliczano
%       wektor błędów całkowania integration_error.
%
%   ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
%
%   [xr, yr] - tablice komórkowe zawierające informacje o wylosowanych punktach.
%       Tablice te mają rozmiar [1, length(Nt)]. W komórkach xr{1,i} oraz yr{1,i}
%       zawarte są współrzędne x oraz y wszystkich punktów zastosowanych
%       do obliczenia całki przy losowaniu Nt(1,i) punktów.
%
%   yrmax - maksymalna dopuszczalna wartość współrzędnej y losowanych punktów

reference_value = 0.0473612919396179; % wartość referencyjna całki
Nt = 5:50:10^4;
integration_error = [];
xr = cell(1, length(Nt));
yr = cell(1, length(Nt));
for i = 1:length(Nt)
    [integration_result, xr{i}, yr{i}, yrmax] = integral_mcarlo(@f, Nt(i));
    integration_error(i) = abs(integration_result - reference_value);
end

ft_5 = f(5);

% plot results
figure;
loglog(Nt, integration_error);
xlabel('Nt');
ylabel('Błąd całkowania');
title('Błąd całkowania w zależności od liczby losowań');
end

function d = f(t)
sig = 3;
u = 10;
d = 1/(sig*sqrt(2*pi)) * exp(-((t-u).^2)/(2*sig^2));
end

function [res, xr, yr, yrmax] = integral_mcarlo (f, N)
a = 0;
b = 5;
yrmax = f(5);
xr = rand(1, N)*(b-a);
yr = rand(1, N)*yrmax;
res = 0;
for i = 1:N
    if yr(i) <= f(xr(i))
        res = res + 1;
    end
end
res = res/N * (b-a) * yrmax;
end
