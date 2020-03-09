function [ inf, sup ] = appeTrain( train, cantElements )
%APPETRAIN Esta función analiza la cota inferior y superior del subconjunto
%de clasificacion
%   inf: cota inferior
%   sup: cota superior
    cantSubgroup = uint32(cantElements/5);
    cantRes      = mod(cantElements,5);
    inf = (train-1)*cantSubgroup+1;
    sup = inf + cantSubgroup - 1;
    if train == 5
        sup = sup + cantRes;
    end
end

