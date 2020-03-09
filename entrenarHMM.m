function [HT, HE] = entrenarHMM(seq, states, symbols)
%ENTRENARHMM Función para entrenar HMM
%   seq -> es la secuencia de entrenamiento, donde se tienen los tipos de
%   diferencias entre radios para cada angulo analizado.
%   states, symbols es la cantidad de estados y simbolos a analizar.
%   HT -> matriz de trancición entre estados.
%   HE -> matriz de trancición para las emisiones.
    T = rand(states, states);
    E = rand(states, symbols);
   [HT, HE] = hmmtrain(seq, T, E, 'maxiterations', 200);
end