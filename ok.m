clc ;close all;  clear all; 
A=imread('~/Documentos/green-laser-2.JPG'); Cr=A(:,:,1); Cg=double(A(:,:,2)); Cb=A(:,:,3);%imagen

[Max,b]=max(Cg(:)); [n_max, m_max] = ind2sub(size(Cg),b); %Maximo y posicion del maximo 

data=Cg(n_max,:)/Max;  dominio=[1:1:length(data)];  dominio=dominio/length(dominio); 

fwhm=(1/2); e_1=(1/exp(1)); e_2=(1/exp(2));%Puntos para cada metodo  

[Cnts,ince]=lsqcurvefit(@myfun1,[1,3,27],dominio,data); %Fit gaussiano de los datos

Ancho_fwhm=Ancho(Cnts,fwhm);  Ancho_e1=Ancho(Cnts,e_1);  Ancho_e2=Ancho(Cnts,e_2);%Ancho para metodo


figure(1); imagesc(Cg); axis image ; improfile; 
title('Imagen de análisis [RGB]'); xlabel('x'),ylabel('y')

figure(3); plot(dominio,data,'.'); hold on; 
plot(dominio,myfun1(Cnts,dominio),'LineWidth',2);grid;
plot(Ancho_fwhm(1:2),[fwhm,fwhm],'k-.','LineWidth',1);
plot(Ancho_e1(1:2),[e_1,e_1],'g-.','LineWidth',1);
plot(Ancho_e2(1:2),[e_2,e_2],'b-.','LineWidth',1);
title('Intensidad vs Posición'); leg1='Datos'; leg2='Fit-Gaussiano';
leg3=strcat('FWHM = ',num2str(Ancho_fwhm(3))); 
leg4=strcat('1/e = ',num2str(Ancho_e1(3)));
leg5=strcat('1/e^2 = ',num2str(Ancho_e2(3)));
legend(leg1,leg2,leg3,leg4,leg5); xlabel('Posición') ; ylabel('Intensidad [RGB]')