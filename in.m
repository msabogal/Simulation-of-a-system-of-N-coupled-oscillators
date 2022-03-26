clc; clear all; close all; 

N=1000; la=0.25; wn= 2; k=linspace(0,pi,N); zi=0.3; 

%%% PARTE LINEAL
om= (wn)./(sqrt(1+2*la*cos(k))); om2=-om; 

%figure(1); hold on
%plot(k,om); plot(k,om2) ; title('omega vs k/ valores propios')

%%%% LA MATRIZ DE AUTO VECTORES (LINEAL)
a= la*ones(1,N-1); b=ones(1,N); 
M= diag(a,-1) + diag(b,0) + diag(a,1) ; M(1,N)=la ; M(N,1)=la; Minv=inv(M); 

W=(wn.^2).*Minv; 

eigen=sqrt(eig(W)); 

%figure(2); hold on  
%plot(k,eigen,'red.') ; plot(k, om,'b-'); title('valores propios exp')

%%
%%% SISTEMA NO LINEAL
%options = optimoptions('fsolve','Display','none','PlotFcn',@optimplotfirstorderopt);
 
N_q=101; omega=1:-1e-2:-eigen(1); la=0.25; wn= 2 ; zi=0.3; 

%qn=[flipud(qn2);qn1]; %fliplr(omega) para girar un vector
   
x0par=zeros(1,N_q); x0par(floor(N_q/2)+1)=1 ; x0par(floor(N_q/2))=1;

x0_asimetrico=zeros(1,N_q); x0_asimetrico(floor(N_q/2))=1;  


qnpar= solveqn(omega,x0par,wn,zi,la);  vnpar= 0.5*wn.^2 .*qnpar.^2 .*(1-0.5*zi*wn.^2.*(wn.*qnpar).^2);  

Hpar=sum(vnpar,2);   omegat=[-fliplr(omega),omega]; 



qnimpar= solveqn(omega,- x0par,wn,zi,la);  vnimpar= 0.5*wn.^2 .*qnimpar.^2 .*(1-0.5*zi*wn.^2.*(wn.*qnimpar).^2);  

Himpar=sum(vnimpar,2); 



qasimetrica= solveqn(omega,x0_asimetrico,wn,zi,la);  v_nasimetrico= 0.5*wn.^2 .*qasimetrica.^2 .*(1-0.5*zi*wn.^2.*(wn.*qasimetrica).^2);  

H_asimetrico=sum(v_nasimetrico,2); 


figure(4);
plot(omegat,Hpar,'o',omegat,Himpar,'x',omegat,H_asimetrico,'.'); xlabel('Valor propio (\Omega)','FontSize',15); ylabel('Hamiltoniano','FontSize',15)
legend('simétrica','antisimétrica','asimétrica'); title('Familia de soluciones (Estacionarias)','FontSize',15); grid


b = (omegat== 0); [n,m]=max(b); l=qasimetrica(m,:); ll=qnpar(m,:); 

figure(5); plot(abs(l),'o-') ; xlim([0,101]); xlabel('Amplitud'); ylabel('Resonador'); title('Solución asimétrica \Omega = 0'); 
figure(6); plot(abs(ll),'o-'); xlim([0,101]); xlabel('Amplitud'); ylabel('Resonador'); title('Solución simétrica \Omega = 0')

%figure(10); imagesc(qnpar); 
%figure(11); imagesc(qasimetrica); 



