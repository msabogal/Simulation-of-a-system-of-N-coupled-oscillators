clc ;close all;  clear all; 
% Lectura de la imagen
A=imread('~/Documentos/green-laser-2.JPG'); 

% Asignacion de cada canal
Cr=double(A(:,:,1)); Cg=double(A(:,:,2)); Cb=double(A(:,:,3)); 

% Posiciones del maximo
[Max,b]=max(Cg(:)); [n_max, m_max] = ind2sub(size(Cg),b); 

%Asignacion de variables 1-D para el fitting, y normalizacion
data_1D=Cg(n_max,:)/Max ;dominio=[1:1:length(data_1D)]; dominio=dominio/length(dominio);  

%Intensidad total
I_total_1D=sum(data_1D);

%Puntos de interes
fwhm=(1/2); e_1=(1/exp(1)); e_2=(1/exp(2)); 

%Intensidad para cada region-1D
I_fwhm_1D=sum(data_1D.*(data_1D>=fwhm))  ; I_fwhm_porcentual_1D=I_fwhm_1D/I_total_1D*100; 
I_exp1_1D=sum(data_1D.*(data_1D>=e_1))   ; I_exp1_porcentual_1D=I_exp1_1D/I_total_1D*100;  
I_exp2_1D=sum(data_1D.*(data_1D>=e_2))   ; I_exp2_porcentual_1D=I_exp2_1D/I_total_1D*100;  

%Asignacion de variables 2-D para el fitting, y normalizacion
data_2D=Cg/Max; I_total_2D=sum(sum(data_2D));  

%Intensidad para cada region-2D
I_fwhm_2D=sum(sum(data_2D.*(data_2D>=fwhm))) ; I_fwhm_porcentual_2D=I_fwhm_2D/I_total_2D*100; 
I_exp1_2D=sum(sum(data_2D.*(data_2D>=e_1)))  ; I_exp1_porcentual_2D=I_exp1_2D/I_total_2D*100;
I_exp2_2D=sum(sum(data_2D.*(data_2D>=e_2)))  ; I_exp2_porcentual_2D=I_exp2_2D/I_total_2D*100; 

%Fit gaussiano de los datos 
[Cnts,ince]=lsqcurvefit(@myfun1,[1,3,27],dominio,data_1D); 

%Determinacion de los anchos para cada punto
Ancho_fwhm=Ancho(Cnts,fwhm);  Ancho_e1=Ancho(Cnts,e_1);  Ancho_e2=Ancho(Cnts,e_2);%Ancho para metodo

%GRAFICAS
figure(1); imagesc(Cg/Max); axis image ; %improfile; 
title('Intensidad [RGB], canal verde','FontSize',15); xlabel('x'),ylabel('y'); 

figure(2); imagesc(Cr/max(max(Cr))); axis image ; %improfile; 
title('Intensidad [RGB], canal rojo','FontSize',15); xlabel('x'),ylabel('y'); 

figure(3); imagesc(Cb/max(max(Cb))); axis image ; %improfile; 
title('Intensidad [RGB], canal azul','FontSize',15); xlabel('x'),ylabel('y'); 

figure(4); plot(dominio,data_1D,'.'); hold on; 
plot(dominio,myfun1(Cnts,dominio),'LineWidth',2);grid;
plot(Ancho_fwhm(1:2),[fwhm,fwhm],'k-.','LineWidth',1);
plot(Ancho_e1(1:2),[e_1,e_1],'g-.','LineWidth',1);
plot(Ancho_e2(1:2),[e_2,e_2],'b-.','LineWidth',1);
title('  Intensidad vs Posición (x)','FontSize',15); leg1='Datos'; leg2='Fit-Gaussiano';
leg3=strcat('FWHM = ',num2str(Ancho_fwhm(3))); 
leg4=strcat('1/e = ',num2str(Ancho_e1(3)));
leg5=strcat('1/e^2 = ',num2str(Ancho_e2(3)));
legend(leg1,leg2,leg3,leg4,leg5); xlabel('Posición (x)','FontSize',15) ; ylabel('I/I_{0}','FontSize',15)

figure(5); 
F=strcat('I_{FWHM} = ',num2str(I_fwhm_porcentual_1D),'%'); 
E1=strcat('I_{1/e} = ',num2str(I_exp1_porcentual_1D),'%');
E2=strcat('I_{1/e^2} = ',num2str(I_exp2_porcentual_1D),'%'); 
Intensidades_1D=[I_fwhm_1D,I_total_1D; I_exp1_1D,I_total_1D; I_exp2_1D,I_total_1D];
nom={F,E1,E2}; 
bar(Intensidades_1D,0.5); set(gca,'XTickLabel',nom,'Fontsize',11);  
leg=legend('Intensidad concentrada','Intensidad total','Location','northoutside','Orientation','horizontal'); 
title(leg,'Intensidad concentrada por region - unidimensional','FontSize',12);

figure(6); 
F1=strcat('I_{FWHM} = ',num2str(I_fwhm_porcentual_2D),'%'); 
E11=strcat('I_{1/e} = ',num2str(I_exp1_porcentual_2D),'%');
E22=strcat('I_{1/e^2} = ',num2str(I_exp2_porcentual_2D),'%'); 
Intensidades_2D=[I_fwhm_2D,I_total_2D; I_exp1_2D,I_total_2D; I_exp2_2D,I_total_2D];
nom={F1,E11,E22}; 
bar(Intensidades_2D,0.5); set(gca,'XTickLabel',nom,'FontSize',11);  
leg=legend('Intensidad concentrada','Intensidad total','Location','northoutside','Orientation','horizontal'); 
title(leg,'Intensidad concentrada por region - bidimensional','FontSize',12);

%Grafica de los anillos
a1=data_2D<=(0.5-0.01) ; b1=data_2D>=(0.5+0.01); c1= a1~=b1; data1=data_2D.*c1;    
a2=data_2D<=(1/exp(1)-0.01); b2=data_2D>=(1/exp(1)+0.01) ; c2= a2~=b2; data2=data_2D.*c2;
a3=data_2D<=(1/exp(2)-0.01); b3=data_2D>=(1/exp(2)+0.01) ; c3= a3~=b3; data3=data_2D.*c3;
data4=data_2D.*c1.*c2.*c3; 
figure(7); imagesc(data4); 
title('Regiones de concentración de intensidad','FontSize',15); xlabel('x'),ylabel('y'); 

%Grafica-3D
%[a,b]=size(Cg); x=[1:1:a];y=[1:1:a]; [X,Y]=meshgrid(x,y); Z=Cg(1:a,1:a);  
%figure(8); mesh(X,Y,Z); 
