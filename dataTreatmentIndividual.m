function [vMax,vMin]=dataTreatmentIndividual(data)

N=length(data); %Tamaño de la muestra

%Calculo de la valores maximo y minimo
vMax=max(data);
vMin=min(data);

%Calculo de la media
media=mean(data);

%Calculo de la mediana
mediana=median(data);

%Calculo de la moda
moda=mode(data);

%Calculo de la media geometrica
mGeometrica=geomean(data);

%Calculo de la media armonica
mArmonica=harmmean(data);

%Calculo de la varianza
varianza=var(data);

%Calculo de la desviacion estandar
dEstandar=std(data);

%Calculo de la asimetria
asim=((sum((data-media).^3))/N)/dEstandar^3;

%Calculo del apuntamiento
apunt=(((sum((data-media).^4))/N)/dEstandar^4)-3;

%Rango intercuartílico
iCuartilico=iqr(data);
%Primer cuartil (percentil 25)
pCuartil=prctile(data, 25);
%Percentil del 5%
pCinco=prctile(data,5);

%Impresion de la Tabla
t=tabulate(data);
tabla = table(t(:,1),t(:,2),t(:,3));
tabla.Properties.VariableNames = {'Valor','Frecuencia','Porcentaje'};
display(tabla)

%Histograma
hold on
histogram(data,'FaceColor','blue')
%histfit(data,N)
legend('Histograma');
title('Histograma de la muestra');


%Impresion de Valores
disp(['01. Tamaño de la muestra : ' num2str(N)]);
disp(['02. Valor minimo         : ' num2str(vMin)]);
disp(['03. Valor maximo         : ' num2str(vMax)]);
disp(['04. Media Aritmetica     : ' num2str(media)]);
disp(['05. Mediana              : ' num2str(mediana)]);
disp(['06. Moda                 : ' num2str(moda)]);
disp(['07. Media Geometrica     : ' num2str(mGeometrica)]);
disp(['08. Media Armonica       : ' num2str(mArmonica)]);
disp(['09. Varianza             : ' num2str(varianza)]);
disp(['10. Desviacion Estandar  : ' num2str(dEstandar)]);
disp(['11. Asimetria            : ' num2str(asim)]);
disp(['12. Apuntamiento         : ' num2str(apunt)]);
disp(['13. Rango intercuartílico: ' num2str(iCuartilico)]);
disp(['14. Primer cuartil       : ' num2str(pCuartil)]);
disp(['15. Percentil del 5%     : ' num2str(pCinco)]);

end