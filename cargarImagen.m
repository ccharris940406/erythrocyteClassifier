-function [caractVectorsC, caractVectorsE, caractVectorsO] = cargarImagen()
diract = cd;
directorio = uigetdir(cd, 'Elige directorio de imagenes circulares');

if isequal(directorio, 0)
    msgbox('No selecciono carpeta', 'ERROR', 'error');
    return;
end

cd(directorio)

listaImagenes = dir('*.jpg');
listaImagenes.name
[cant,~] = size(listaImagenes);

if cant == 0
    msgbox('No se encontro ninguna imagen en esta carpeta', 'ERROR', 'error');
    cd(diract)
    return
end

names = cell(cant,1);

for i = 1:cant
    names{i} = listaImagenes(i).name;
end

names

caractVectorsC = 0;
caractVectorsE = 0;
caractVectorsO = 0;
end
 