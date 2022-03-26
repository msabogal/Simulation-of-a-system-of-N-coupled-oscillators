clc ;close all;  clear all; 
x0=[1,0,0]; v0=[0,0,0]; X0=[x0(:);v0(:)]; N=3;
k=1; kc1=1; kc2=1; m=1; a=[(-1/m)*(k+kc1),(-1/m)*(kc2+kc1),(-1/m)*(k+kc2)]; 
b=[kc1/m,kc2/m]; iden=eye(N); cero=zeros(N); 

M=diag(a,0)+diag(b,1)+diag(b,-1); M1=[cero,iden;M,cero];

%options=odeset('RelTol',1e-8,'Abstol',1e-8);
[t,y]=ode45(@(t,X) M1*X,[0 10],X0); 
x1=y(:,1); x2=y(:,2); x3=y(:,3) ;v1=y(:,4); v2=y(:,5); v3=y(:,6);  

%energia
U=0.5*k*x1.^2 + 0.5*kc1*(x2-x1).^2 +0.5*kc2*(x3-x2).^2 +0.5*k*x3.^2; 
K=0.5*m*v1.^2 +0.5*m*v2.^2 +0.5*m*v3.^2; Et=U+K; 

K1=0.5*m*v1.^2; K2=0.5*m*v2.^2; K3=0.5*m*v3.^2; 
U1=0.5*k*x1.^2; U2=0.5*k*x2.^2; U3=0.5*k*x3.^2; 
E1=K1+U1;E2=K2+U2;E3=K3+U3;  

figure(1); plot(t,x1,t,x2,t,x3); title('posiciones vs tiempo'); 
figure(2); plot(t,v1,t,v2,t,v3); title('velocidades vs tiempo'); 
figure(3); plot(t,U,t,K,t,Et); title('Energia vs tiempo'); 

figure(4); plot(t,U1,t,K1,t,E1)
figure(5); plot(t,U2,t,K2,t,E2)
figure(6); plot(t,U3,t,K3,t,E3)