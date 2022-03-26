clc; clear all; close all; 

N=1000; la=0.25; wn= 2; k=linspace(0,pi,N); zi=0.3; 

%%% PARTE LINEAL
om= (wn)./(sqrt(1+2*la*cos(k))); om2=-om; 

figure(1); hold on
plot(k,om,'LineWidth',1.6); plot(k,om2,'LineWidth',1.6) ; title('Relación de dispersión');
ylabel('Valor propio (\Omega)','FontSize',15); xlabel('k','FontSize',15)

%%%% LA MATRIZ DE AUTO VECTORES (LINEAL)
a= la*ones(1,N-1); b=ones(1,N); 
M= diag(a,-1) + diag(b,0) + diag(a,1) ; M(1,N)=la ; M(N,1)=la; Minv=inv(M); 

W=(wn.^2).*Minv; 

eigen=sqrt(eig(W)); 

figure(2); hold on  
plot(k,eigen,'red.','LineWidth',1.2) ; plot(k,om,'b--','LineWidth',1.2);  
plot(k,-eigen,'k.','LineWidth',1.2) ; plot(k,om2,'m--','LineWidth',1.2);  legend('\Omega diagonalización','\Omega teorico','\Omega  diagonalización','\Omega teorico') 
title('Comparación de la relacion de dispersión','LineWidth',1.2) ; 
ylabel('Valor propio (\Omega)','FontSize',15); xlabel('k','FontSize',15); 
