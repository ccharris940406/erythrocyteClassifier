function [] = clasificar( )
%CLASIFICAR Clasifica los conjuntos destinados a etiquetarse.
%   Detailed explanation goes here
c = ['CEO'];
for i = 1:5
    %cargardo HMMs para la clasificacion
    File = strcat('HMMC', int2str(i));
    load(File);
    HMMCT = HMMT;
    HMMCE = HMME;
    File = strcat('HMME', int2str(i));
    load(File);
    HMMET = HMMT;
    HMMEE = HMME;
    File = strcat('HMMO', int2str(i));
    load(File);
    HMMOT = HMMT;
    HMMOE = HMME;
    
    for j = 1:3
        File = strcat('Class',c(j), int2str(i));
        load(File);
        [cant, ~] = size(classification);
        res = cell(cant,1);
        for kk = 1: cant
            %clasificando cada elemento de los conjuntos de clasificacion.
            [~, pC] = hmmdecode(classification{kk,1}, HMMCT, HMMCE);
            [~, pE] = hmmdecode(classification{kk,1}, HMMET, HMMEE);
            [~, pO] = hmmdecode(classification{kk,1}, HMMOT, HMMOE);
            res{kk,1} = [pC pE pO];
        end
        FileR = strcat('Res', c(j), int2str(i));
        save(FileR, 'res');
    end
    
    
    
end

