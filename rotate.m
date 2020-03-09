function [rot] = rotate(vect,pos, cant)
%ROTATE Rotar un vector.
%   pos donde comienza la rotacion
    rot = [vect(pos:cant) vect(1: pos-1)];
end

