function [dif] = difCalculate(X, Y, U1, U2)
%DIFCALCULATE Calcula el tipo de diferencia que existen entre los puntos
%del contorno, que son 1, 2 o 3 dependiendo de los ubrales
%   Detailed explanation goes here
    d = abs(X - Y);
    if d <= U1
        dif = 1;
    elseif d <= U2
        dif = 2;
    else
        dif = 3;
    end

end

