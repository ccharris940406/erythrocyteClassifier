function [featVs, lon] = extractFeat(cad)
%extractFeat Esta función se encarga de cargar el contorno y dar
%una representación de este.
%   El parametro de la funcion es el tipo de eritrocito a cargar.
  
    diract = cd;
    path = uigetdir(cd, ['Elige directorio de contornos ' cad]);
    if isequal(path, 0)
        msgbox('Debe seleccionar alguna carpeta que contenga contornos ', 'ERROR', 'error');
        return;
    end
    cd(path);
    contourList = dir('*.mat');
    lon = length(contourList);
    if lon == 0
         featVs = [];
        return;
    end
    
    featVs = cell(lon, 1);
    
    for k = 1:lon
        imgName = contourList(k).name;
        img = load(imgName);
        XX = img.contor(2,:); %tomando axisas
        YY = img.contor(1,:); %tomando ordenadas
        %figure; plot(XX, YY,'b');
        %hold on; plot(XX, YY, 'b');
        Cx = img.centroide(2); %X del centro
        Cy = img.centroide(1); %Y del centro
        %hold on; plot(Cx, Cy, 'bp');
        rads = [];
        angulos = [];
        %[rad, angle] = polarizar(Cx, Cy, XX(180), YY(180));
        for i = 1:295
            [rad, angle] = polarizar(Cx, Cy, XX(i), YY(i));
            rads = [rads rad];
            angulos = [angulos angle];
        end
        [angleS, I] = sort(angulos);
        %figure; plot(angulos, rads, '*');
        radsS = [];

        for i = 1: 295
            radsS = [radsS rads(I(i))];
        end

        %hold on; plot(angleS, radsS, 'go')

        xp = [1:1:360];
        ver = [1:1:295];
        %angleS
        %figure; plot(angleS(1:1:295), radsS(1:1:295), '.');
        for r = 2:295
            dd = angleS(r) - angleS(r-1);
            if dd <= 0
                angleS(r) = angleS(r-1) + 0.00001;
               
            end
        end
        
        featureVector = interp1(angleS(1:295), radsS(1:295), xp, 'pchip');
        %hold on; plot(xp, featureVector, 'g--');
        
        Xx = [];
        Yy = [];
        
        for w = 1:360
            Xx = [Xx Cx + cosd(w)*featureVector(w)];
            Yy = [Yy Cy + sind(w)*featureVector(w)];
        end
        %hold on; plot(Xx, Yy, 'r');
        featVs{k,1} = featureVector;
    end
    
    cd(diract);
    
end

