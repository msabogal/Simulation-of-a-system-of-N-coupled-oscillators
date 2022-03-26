clc ;close all;  clear all; 
%Condiciones de entrada
N=3; tf=50; 

%Condiciones iniciales
x0=zeros(N,1); x0(floor(N/2)+1)=1;v0=zeros(N,1); X0=[x0;v0]; 

%Asignacion de parametros extremos
ki= 0.9; kf= 1.1; mi=1; mf=1; iden=eye(N); cero=zeros(N); 

%Asigacion de parametros
mm= mi + (mf-mi)*rand(1,N); kk= ki + (kf-ki)*rand(1,N+1); 

%Diagonales 
W2= kk(2:N)./mm(2:N) ;   W1= (-1)*( kk(1:N) + kk(2:N+1) )./mm ;  W3= kk(2:N)./mm(1:N-1);

%Matrices de las EDO
M=diag(W1,0)+diag(W3,1)+diag(W2,-1); M1=[cero,iden;M,cero];

%Evolucion del sistema
options=odeset('RelTol',1e-10,'Abstol',1e-10);
[t,y]=ode45(@(t,X) M1*X,[0 tf],X0,options);  

%Asignacion de variables
pos=y(:,1:N); vel=y(:,N+1:2*N); 

%Calulo de las energias del sistema
u=[0.5*kk(1)*pos(:,1).^2 ,0.5*kk(2:N).*( pos(:,2:N)-pos(:,1:N-1)).^2 , 0.5*kk(N+1)*pos(:,N).^2];  U=sum(u,2); 
ek=0.5.*mm.*vel.^2; K=sum(ek,2); 
Et=U+K; 

%Calculo de R_A
num_RA= sum(pos.^2,2).^2; den_RA=sum(pos.^4,2); R_A= num_RA./den_RA;

%Calculo de las energias individuales 
et1=0.5*kk(1)*pos(:,1).^2+ 0.25*kk(2)*(pos(:,2)-pos(:,1)).^2 + 0.5*mm(1)*(vel(:,1)).^2;
etn=0.25*kk(2:N-1).*(pos(:,2:N-1)-pos(:,1:N-2)).^2 + 0.25*kk(3:N).*(pos(:,3:N)-pos(:,2:N-1)).^2 + 0.5*mm(2:N-1).*(vel(:,2:N-1)).^2; 
etn1=0.5*kk(N+1)*pos(:,N).^2+ 0.25*kk(N)*(pos(:,N)-pos(:,N-1)).^2 + 0.5*mm(N)*(vel(:,N)).^2;

%Calculo de R_E
ETR=[et1,etn,etn1]; up=sum(ETR.^2,2).^2 ; down=sum(ETR.^4,2) ;
R_E2=up./down;

%Calculo de m1 y m2
i_i=1:1:N;  arr=sum(i_i.*(ETR.^2),2); deb=sum(ETR.^2,2);  m1=arr./deb; 

arr2=sum((i_i.^2).*(ETR.^2),2);  m2= arr2./deb;

%GRAFICAS
figure(1); plot(t,pos,'LineWidth',1.2); title('Posicion vs tiempo','FontSize',15); legend('m1','m2','m3'); 
xlabel('Tiempo','FontSize',15);  ylabel('Desplazamiento en x','FontSize',15,'FontSize',15);grid; 

figure(2); plot(t,vel,'LineWidth',1.2); title('Velocidad vs tiempo','FontSize',15); legend('m1','m2','m3');
xlabel('Tiempo','FontSize',15);  ylabel('Velocidad','FontSize',15);grid; 

figure(3); plot(t,U,t,K,t,Et,'LineWidth',1.2); title('Energia del sistema vs tiempo','FontSize',15);legend('U','K','Et'); 
xlabel('Tiempo','FontSize',15);  ylabel('Energia','FontSize',15);grid; 

figure(4); plot(pos,vel); title('Velocidad vs Posicion / Espacio de fase','FontSize',15); 
legend('m1','m2','m3'); xlabel('Desplazamiento en x','FontSize',15);  ylabel('Velocidad','FontSize',15);grid; 

figure(5); imagesc(pos); title('Evolución de las posiciones','FontSize',15); 
xlabel('Oscilador','FontSize',15);  ylabel('Iteraciones','FontSize',15);

figure(11); imagesc(abs(pos)); title('Propagacion de la perturbación','FontSize',15); 
xlabel('Oscilador','FontSize',15);  ylabel('Iteraciones','FontSize',15);

figure(6); 
plot(t,R_A,t,R_E2); title('Grado de participación vs t','FontSize',15); xlabel('t'),ylabel('R'); 
legend('R','ER'); 

figure(8); plot(t,m1); title('m1 vs t'); xlabel('t'),ylabel('m1');

figure(9); plot(t,m2); title('m2 vs t'); xlabel('t'),ylabel('m2');

figure(10); imagesc(ETR); title('Evolucion de la energia de cada oscilador','FontSize',15); 
xlabel('Oscilador','FontSize',15);  ylabel('Iteraciones','FontSize',15);

