clc ;close all;  clear all; 
% Lectura de la imagen
A=imread('~/Documentos/green-laser-2.JPG');

% imagen en escala de grises 
B=double(rgb2gray(A)); %improfile;

% Posiciones del maximo
[Max,b]=max(B(:)); [n_max, m_max] = ind2sub(size(B),b); %Maximo y posicion del maximo

%Asignacion de variables 1-D para el fitting, y normalizacion
data_1D=B(n_max,:)/Max;  dominio=[1:1:length(data_1D)];  dominio=dominio/length(dominio); 

%Intensidad total
I_total_1D=sum(data_1D);

% Puntos de interes
fwhm=(1/2); e_1=(1/exp(1)); e_2=(1/exp(2)); 

%Intensidad para cada region-1D
I_fwhm_1D=sum(data_1D.*(data_1D>=fwhm))  ; I_fwhm_porcentual_1D=I_fwhm_1D/I_total_1D*100; %intensidades 1-D
I_exp1_1D=sum(data_1D.*(data_1D>=e_1))   ; I_exp1_porcentual_1D=I_exp1_1D/I_total_1D*100;  
I_exp2_1D=sum(data_1D.*(data_1D>=e_2))   ; I_exp2_porcentual_1D=I_exp2_1D/I_total_1D*100;  

%Asignacion de variables 2-D para el fitting, y normalizacion
data_2D=B/Max; I_total_2D=sum(sum(data_2D));  

%Intensidad para cada region-2D
I_fwhm_2D=sum(sum(data_2D.*(data_2D>=fwhm))) ; I_fwhm_porcentual_2D=I_fwhm_2D/I_total_2D*100; 
I_exp1_2D=sum(sum(data_2D.*(data_2D>=e_1)))  ; I_exp1_porcentual_2D=I_exp1_2D/I_total_2D*100;
I_exp2_2D=sum(sum(data_2D.*(data_2D>=e_2)))  ; I_exp2_porcentual_2D=I_exp2_2D/I_total_2D*100; 

 %Fit gaussiano de los datos
[Cnts,ince]=lsqcurvefit(@myfun1,[1,3,27],dominio,data_1D);

%Determinacion de los anchos para cada punto
Ancho_fwhm=Ancho(Cnts,fwhm);  Ancho_e1=Ancho(Cnts,e_1);  Ancho_e2=Ancho(Cnts,e_2);

%GRAFICAS
figure(1); imagesc(B/Max); axis image ; %improfile; 
title('Intensidad en escala de grises','FontSize',15); xlabel('x'),ylabel('y'); 

figure(2); plot(dominio,data_1D,'.'); hold on; 
plot(dominio,myfun1(Cnts,dominio),'LineWidth',2);grid;
plot(Ancho_fwhm(1:2),[fwhm,fwhm],'k-.','LineWidth',1);
plot(Ancho_e1(1:2),[e_1,e_1],'g-.','LineWidth',1);
plot(Ancho_e2(1:2),[e_2,e_2],'b-.','LineWidth',1);
title('  Intensidad vs Posición (x)','FontSize',15); leg1='Datos'; leg2='Fit-Gaussiano';
leg3=strcat('FWHM = ',num2str(Ancho_fwhm(3))); 
leg4=strcat('1/e = ',num2str(Ancho_e1(3)));
leg5=strcat('1/e^2 = ',num2str(Ancho_e2(3)));
legend(leg1,leg2,leg3,leg4,leg5); xlabel('Posición (x)','FontSize',15) ; ylabel('I/I_{0}','FontSize',15)

figure(3); 
F=strcat('I_{FWHM} = ',num2str(I_fwhm_porcentual_1D),'%'); 
E1=strcat('I_{1/e} = ',num2str(I_exp1_porcentual_1D),'%');
E2=strcat('I_{1/e^2} = ',num2str(I_exp2_porcentual_1D),'%'); 
Intensidades_1D=[I_fwhm_1D,I_total_1D; I_exp1_1D,I_total_1D; I_exp2_1D,I_total_1D];
nom={F,E1,E2}; 
bar(Intensidades_1D,0.5);
set(gca,'XTickLabel',nom,'FontSize',11);  
leg=legend('Intensidad concentrada','Intensidad total','Location','northoutside','Orientation','horizontal'); 
title(leg,'Intensidad concentrada por region - unidimensional','FontSize',12);

figure(4); 
F1=strcat('I_{FWHM} = ',num2str(I_fwhm_porcentual_2D),'%'); 
E11=strcat('I_{1/e} = ',num2str(I_exp1_porcentual_2D),'%');
E22=strcat('I_{1/e^2} = ',num2str(I_exp2_porcentual_2D),'%'); 
Intensidades_2D=[I_fwhm_2D,I_total_2D; I_exp1_2D,I_total_2D; I_exp2_2D,I_total_2D];
nom={F1,E11,E22}; 
bar(Intensidades_2D,0.5);
set(gca,'XTickLabel',nom,'FontSize',11);  
leg=legend('Intensidad concentrada','Intensidad total','Location','northoutside','Orientation','horizontal'); 
title(leg,'Intensidad concentrada por region - bidimensional','FontSize',12);