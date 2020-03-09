nStates = 3; %Cantidad de estados para HMM.
nSymbols = 3; %Cantidad de symbolos para HMM.
changeResol = 4; %Numero para cambiar resoluciones, tiene relacion con los 
                 %espacios entre angulos Ej->{spaceBetRads = 18, changeResol =3}.
                 %18/3 = 6 las resoluciones 3 veces (18, 12, 6).
spaceBetRads = 20; %Espacio entre angulos.
nclases = 3; %Numero de clases a clasificar.
nPartes = 5; %Numero de particiones para la clasificación cruzada.
umbral1 = 2.5;
umbral2 = 5.5;
tRotate = 2; %Tipo de rotaciones: 0-ninguna, 1-orientar en el mayor eje, 2-rotando todos los ptos. 
type = [{' Circulares'} {' Elongados'} {' OtrasDef'}];

%cargando contornos en [~,1] están los contornos y en [~,2] está la
%cantidad de contornos a analizar.
[featVectors{1,1}, featVectors{1,2}]= extractFeat('circulares'); %circulares
[featVectors{2,1}, featVectors{2,2}]= extractFeat('elongadas'); %elongadas
[featVectors{3,1}, featVectors{3,2}]= extractFeat('otras'); %otras

for k = 1: nclases
    cantVectors = featVectors{k,2}; %cantidad de vectores de caracteristicas
                                    %de una clase.
    vectors = featVectors{k,1};     %vectores de caracteristicas de una clase.
    seq = cell(cantVectors,1);      %quedan los tipos de diferencia para cada
                                    %vector de caracteristicas.
    
    for i = 1: cantVectors
        vector = vectors{i};
        if tRotate == 1            %Orientar en el mayor eje si tRotate == 1                    
            [~,pp] = max(vector);   %Buscando mayor eje
            vector = rotate(vector, pp,360); %Orientando en el mayor eje.
        end
        dif = [];                   %vector de tipos de diferencias
        currentSpace = spaceBetRads; %actual espacio
        reduct = spaceBetRads/changeResol;
        for reso = 1:changeResol %tipos de resoluciones
            currentU1 = (umbral1*currentSpace)/spaceBetRads;
            currentU2 = (umbral2*currentSpace)/spaceBetRads;
            for j = currentSpace:currentSpace:360 %armando vector de diferencias
                dif = [dif difCalculate(vector(j - currentSpace + 1), vector(j), currentU1, currentU2)];
            end
            currentSpace = currentSpace - reduct;
        end
        tam = size(dif);
        seq{i,1} = dif(1,:);
    end
    lonSeq = size(seq{1});
    mul = 1;
    if tRotate == 2
        mul = lonSeq(2);
    end
    for clasi = 1:5
        [infC,supC] = appeTrain(clasi, cantVectors);
        training = cell((cantVectors - ((supC - infC)+1))*mul,1);
        inc = 0;
        for train = 1:5
            if train ~= clasi
                [inf, sup] = appeTrain(train,cantVectors);
                for kk = inf:sup
                    rotated = seq{kk,1};
                    for rot = 1: mul
                        inc = inc + 1;
                        training{inc,1} = rotated;
                        rotated = rotate(rotated,2,mul);
                    end
                    %inc = inc + 1;
                    %training{inc,1} = seq{kk,1};
                end 
            end
        end
        FileT = [strcat('HMM',type{k}(2),int2str(clasi))];
        [HMMT, HMME] = entrenarHMM(training, nStates, nSymbols);
        save(FileT, 'HMMT', 'HMME');
        
        classification = cell((supC - infC) + 1, 1);        
        inc = 0;
        for kk = infC: supC
            inc = inc + 1;
            classification{inc,1} = seq{kk,1}; 
        end
        FileC = strcat('Class', type{k}(2), int2str(clasi));
        save(FileC, 'classification');        
    end
    strcat(['Realizado para '], type(k))
end

clasificar();
imprimir(tRotate, umbral1, umbral2, spaceBetRads, changeResol);


%decod = seq{1};    
%decodm = [3 1 1 1 1 1 2 1 1 1 1 3 1 1 1 1 1 3];
%[~,p] = hmmdecode(decodm, HMMT, HMME)
%[s, e] = hmmgenerate(18,  HMMTC, HMMEC)
