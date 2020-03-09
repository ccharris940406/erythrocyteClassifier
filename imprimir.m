function [] = imprimir( tRot, U1, U2, spaBetRads, resol )
%IMPRIMIR Imprime los resultados de los experimentos
%

    file = strcat(['resultados_R_'], int2str(tRot), '_U1_', int2str(U1), '_U2_', int2str(U2),'_Spc_', int2str(spaBetRads),'_Rs_', int2str(resol),'.txt');
    hfile = fopen(file, 'w+');
    c = ['CEO'];
    for i = 1: 3
        fprintf(hfile, '%s\n', c(i));
        fprintf(hfile, '   P.circular   P.elongadas   P.Otras\n');
        cant = 0;
        diferent = 0;
        for j = 1: 5
            fileLoad = strcat('Res',c(i),int2str(j));
            load(fileLoad);
            [lon, ~] = size(res);
            for k = 1: lon
                [~,sol] = max(res{k});
                fprintf(hfile, '%6.10f %6.10f %6.10f %6s\n', res{k,1}, c(sol));
                if c(sol) ~= c(i)
                    diferent = diferent + 1;
                end
                cant = cant + 1;
            end
        end
       porcent = (diferent*100)/cant;
       signedPC = '%';
       fprintf(hfile, '%d %d %6.10f%s\n', cant, diferent, 100-porcent,signedPC);
    end
    
    fclose(hfile);

end

