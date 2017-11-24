function [vMax,vMin]=dataTreatmentClass(data)

N=length(data); %Calculo del tamaño de la muestra
nsobre2=N/2; 

%Calculo de coeficiente para las clases
k=floor(1+(3.332*log10(N)));

%Calculo de valores minimo y maximo
vMax=max(data);
vMin=min(data);

%Calculo de la Amplitud
amp=(vMax-vMin)/k;

dataMain=zeros(3,k);
%Calculo de rangos
for clase=1:k
dataMain(1,clase)=vMin+(clase-1)*amp;   %Calculo de rango inferior
dataMain(2,clase)=vMin+(clase)*amp;     %Calculo de rango superior
dataMain(3,clase)=(dataMain(1,clase)+dataMain(2,clase))/2;     %Calculo del punto medio
end


frecuenciai=zeros(1,k);

%Determinacion de frecuencia en las marcas de clase
for tam=1:N      
    for sizeClass=1:k
        if(sizeClass==k)
            if(data(tam)>=dataMain(1,sizeClass)&& data(tam)<=dataMain(2,sizeClass))
            frecuenciai(sizeClass)=frecuenciai(sizeClass)+1;
            end
        else
            if(data(tam)>=dataMain(1,sizeClass)&& data(tam)<dataMain(2,sizeClass))
                frecuenciai(sizeClass)=frecuenciai(sizeClass)+1;
            end
        end
    end
end
data
frecuenciai
%Calculo de la frecuencia acumulada
fAcumulada=cumsum(frecuenciai);

%Asignacion de puntos medios
Xi=dataMain(3,:);
dataMain
%Calculo Puntos medios por frecuencias
xifi=Xi.*frecuenciai;
xi2fi=(Xi.^2).*frecuenciai;

%Calculo de la media
media=sum(xifi)/N;

%Busqueda del indice del valor de la mediana
for j=1:k
    if(fAcumulada(j)>nsobre2)
        indiceForMediana=j;
        break;
    end
end
indiceForMediana
%Calculo de la mediana
mediana=dataMain(1,indiceForMediana)+((nsobre2-fAcumulada(indiceForMediana-1))/frecuenciai(indiceForMediana))*amp;

[~,indiceForModa]=max(frecuenciai); %Busqueda del indice del valor de la moda
%Calculo de la moda
moda= Xi(indiceForModa);

%Calculo de la media geometrica
mGeometricaCount=1;
for l=1:k
    mGeometricaCount=mGeometricaCount*(Xi(l)^frecuenciai(l));  %Multiplicacion por partes
end
mGeometrica=mGeometricaCount^(1/N); %Media geometrica total

%Calculo del media armonica
mArmonica=N/(sum(frecuenciai./Xi));

%Calculo de la varianza
varianza=(sum(xi2fi)/N)-media.^2;

%Calculo de la desviacion estandar
dEstandar=((sum(frecuenciai.*(Xi-media).^2))/(N-1))^(1/2);

%Calculo de la asimetria
asim=((sum(frecuenciai.*(Xi-media).^3))/N)/dEstandar^3;

%Calculo del apuntamiento
apunt=(((sum(frecuenciai.*(Xi-media).^4))/N)/dEstandar^4)-3;

%Histograma
hold on
%histogram(data)
bar(Xi,frecuenciai,'blue')
plot([0 Xi vMax+1],[0 frecuenciai 0],'green')
legend('Histograma','Poligono de frecuencias');
title('Histograma de la muestra');

%Impresion de la tabla
tabla = table(dataMain(1,:)',dataMain(2,:)',frecuenciai',fAcumulada',Xi');
tabla.Properties.VariableNames = {'RangoInferior','RangoSuperior','Frecuenciafi','FrecuenciaAcumulada','MarcaClaseXi'};
display(tabla);

%Impresion de valores
disp(['01. Tamaño de la muestra: ' num2str(N)]);
disp(['02. k                   : ' num2str(k)]);
disp(['03. Amplitud            : ' num2str(amp)]);
disp(['04. Valor minimo        : ' num2str(vMin)]);
disp(['05. Valor maximo        : ' num2str(vMax)]);
disp(['06. Media Aritmetica    : ' num2str(media)]);
disp(['07. Mediana             : ' num2str(mediana)]);
disp(['08. Moda                : ' num2str(moda)]);
disp(['09. Media Geometrica    : ' num2str(mGeometrica)]);
disp(['10. Media Armonica      : ' num2str(mArmonica)]);
disp(['11. Varianza            : ' num2str(varianza)]);
disp(['12. Desviacion Estandar : ' num2str(dEstandar)]);
disp(['13. Asimetria           : ' num2str(asim)]);
disp(['14. Apuntamiento        : ' num2str(apunt)]); 

end



