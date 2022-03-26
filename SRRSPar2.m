clc; clear all; close all;  %%% PARA SOLUCIONES PARES 
%%% Parametros
N_q=101; omega=1:-1e-2:-1.6; la=0.25; wn= 2 ; zi=0.3; 

%%% Condicion inicial 
x0=zeros(1,N_q);  x0(floor(N_q/2)+1)=0 ; x0(floor(N_q/2))=1; CCI=x0; 

%%% Se soluciona el sistema de N resonadores 
qn= solveqn(omega,x0,wn,zi,la);  

%%% Potencial y Hamiltoniano de los N resonadores
vn= 0.5*wn.^2 .*qn.^2 .*(1-0.5*zi*wn.^2.*(wn.*qn).^2);  

Hn=sum(vn,2);   omegat=[-fliplr(omega),omega]; 

%%% Observar la solucion para un valor propio determinado
b= (omega==0.4); [n,m]=max(b); solucion=qn(m,:); 



%%%% dinamica 
%Condiciones iniciales

x0= qn(m,:); 
x0=x0(:); 
v0=zeros(N_q,1); X0=[x0;v0]; 
tf=40; 
%Evolucion del sistema
options=odeset('RelTol',1e-10,'Abstol',1e-10);
[t,y]=ode45(@(t,X) propagar(t,X,zi,wn,la),[0 tf],X0,options); 

Qn=y(:,1:N_q); Qnv=y(:,N_q+1:2*N_q); 

%%% HAMILTON
DI= 0.5*[(Qnv(:,1).^2 + la*Qnv(:,1).*Qnv(:,2)) , Qnv(:,2:N_q-1).^2 + la*Qnv(:,2:N_q-1).*( Qnv(:,1:N_q-2) + Qnv(:,3:N_q) ), Qnv(:,N_q).^2 + la*Qnv(:,N_q).*Qnv(:,N_q)]; 
VI= 0.5*wn.^2 .*Qn.^2 .*( 1 - 0.5*zi*wn.^2.*(wn.*Qn).^2);  
HN=DI+VI; 
hj=sum(HN,2); 
di= sum(DI,2); vi=sum(VI,2); 
%%%Graficas
figure(1);
plot(omegat,Hn,'.'); xlabel('omega'); ylabel('Hn') ; legend('Famila')

figure(2); plot(solucion); xlabel('Resonador'); ylabel('Amplitud (qn)') ; title('Solucion estacionaria a propagar')

figure(3); imagesc(qn); xlabel('Resonador'); ylabel('Omega') ; title('Soluciones estacionarias')

figure(4); plot(t,Qn);  xlabel('Tiempo'); ylabel('Amplitud (Qn)') ; title('Qn vs t')

figure(5); plot(t,hj,t,di,t,vi);  xlabel('Tiempo'); ylabel('Energia') ; title('Energias vs t') ; legend('Hn','K','V')

figure(6); imagesc(Qn) ; title('Solucion propagada (Amplitud en colores)');  xlabel('Resonador'); ylabel('tiempo'); 
