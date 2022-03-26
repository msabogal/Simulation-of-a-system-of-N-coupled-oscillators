clc; clear all ; close all; 
%Asigacion de Entradas
N=101; ki=0.7; kf=1.3; mi=1; mf=1; tf=50; N_cal=99; 

%Bucle 
data=ocsg(N,ki,kf,mi,mf,tf); 
for i=1:N_cal
    exp1=ocsg(N,ki,kf,mi,mf,tf); 
    data=data+exp1; 
end

%Asigancion de variables
data=data/(N_cal+1); t=data(:,1);  R_A=data(:,2); R_E2=data(:,3); m1=data(:,4); m2=data(:,5); 

%Graficas 
figure(1); plot(t,R_A,t,R_E2); legend('RA','RE'); 
title('Grado de participación vs t','FontSize',15); xlabel('t'),ylabel('R'); 
figure(2); plot(t,m1); title('m1 vs t'); xlabel('t'),ylabel('m1');
figure(3); plot(t,m2); title('m2 vs t'); xlabel('t'),ylabel('m2');