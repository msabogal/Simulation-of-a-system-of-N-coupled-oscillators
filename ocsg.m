function f=ocsg(N,ki,kf,mi,mf,tf)
%Condiciones iniciales
x0=zeros(N,1); x0(floor(N/2)+1)=1;  v0=zeros(N,1); X0=[x0;v0]; t=linspace(0,tf,10000);

%Asigancion de parametros
mm= mi + (mf-mi)*rand(1,N);  kk= ki + (kf-ki)*rand(1,N+1); iden=eye(N); cero=zeros(N); 

%Diagonales 
W2= kk(2:N)./mm(2:N) ;  W1= (-1)*( kk(1:N) + kk(2:N+1) )./mm ; W3= kk(2:N)./mm(1:N-1);

%Matrices de las EDO
M=diag(W1,0)+diag(W3,1)+diag(W2,-1); M1=[cero,iden;M,cero];

%Evolcion del sistema RK4
[t,y]=ode45(@(t,X) M1*X,t,X0);

%Asignacion de variables
pos=y(:,1:N); vel=y(:,N+1:2*N); 

%Calculo de  las energias del sistema
u=[0.5*kk(1)*pos(:,1).^2 ,0.5*kk(2:N).*( pos(:,2:N)-pos(:,1:N-1)).^2 , 0.5*kk(N+1)*pos(:,N).^2];  U=sum(u,2); 
ek=0.5.*mm.*vel.^2; K=sum(ek,2); 
Et=U+K; 

% Calculo de R_A
num_RA= sum(pos.^2,2).^2; den_RA=sum(pos.^4,2); R_A= num_RA./den_RA;

% Calculo de las energias individuales 
et1=0.5*kk(1)*pos(:,1).^2+ 0.25*kk(2)*(pos(:,2)-pos(:,1)).^2 + 0.5*mm(1)*(vel(:,1)).^2;
etn=0.25*kk(2:N-1).*(pos(:,2:N-1)-pos(:,1:N-2)).^2 + 0.25*kk(3:N).*(pos(:,3:N)-pos(:,2:N-1)).^2 + 0.5*mm(2:N-1).*(vel(:,2:N-1)).^2; 
etn1=0.5*kk(N+1)*pos(:,N).^2+ 0.25*kk(N)*(pos(:,N)-pos(:,N-1)).^2 + 0.5*mm(N)*(vel(:,N)).^2;

%Calculo de R_E
ETR=[et1,etn,etn1]; up=sum(ETR.^2,2).^2 ; down=sum(ETR.^4,2) ;
R_E2=up./down;

%Calculo de m1
i_i=1:1:N;  arr=sum(i_i.*(ETR.^2),2); deb=sum(ETR.^2,2);   m1=arr./deb; 

%Calculo de m2
arr2=sum((i_i.^2).*(ETR.^2),2);  m2= arr2./deb;  

%Salida
f=[t,R_A,R_E2,m1,m2];
end  