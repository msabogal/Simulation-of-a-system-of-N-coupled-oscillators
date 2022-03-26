clc;close all; clear all;

n=100; %m=rand(1,n); 
ki=0.9; kf=1.1;
k=ki+(kf-ki)*(rand(1,n+1));
%k=ones(1, n+1); k=rand(1,n+1);
m=1*ones(1,n);
M = (zeros(n));
diag_prin= (-(k(2:n+1) + k(1:n))./m).*ones(1,n); %( -(k+k)/m).*ones(1,n);
diag_sup = (k(2:n)./m(2:n)).*ones(1,n-1); %(k/m).*ones(1,n-1);  
diag_inf = (k(2:n) ./ m(2:n)).*ones(1,n-1);  %(k / m).*ones(1,n-1); 

M = diag(diag_sup,1)+diag(diag_prin,0)+ diag(diag_inf,-1); 
M2=[zeros(n),eye(n); M, zeros(n)]; %Matriz general

tspam= [0, 30]; options=odeset('RelTol',1e-10,'Abstol',1e-10);
yo=zeros(2*n,1); yo(n/2)=1; %pos1, pos2, vel1, vel2; yo(tal)=pos que le imrecno el delta
[t,y]= ode45(@(t,y) M2*y, tspam, yo,options);

pos=y(:, 1:n); vel=y(:, n+1:2*n); %Posiciones y velocidades

figure(1); plot(t,pos); %Posiciones
figure(2); plot(t,vel); %Velocidades

%Energia    (Revisar energias)
K=(0.5)*(sum(m.*(vel.^2), 2)); %HAY que sumar componente a comonete
delta = k(2:n).*((pos(:,2:n)-pos(:,1:n-1)).^2);
serie=sum(delta, 2);
U=(0.5)*(k(1)*pos(:,1).^2 +serie+ k(n+1)*pos(:,n).^2);  %sum(vel, 2)=suma las columnas y nos da una sola
ET=K+U;    %pos(posicion, columna)
figure(3); plot(t,ET, t,K, t,U);
figure(4); imagesc(pos); %muestra la reparticion de energia

%Grafica de R
R=(sum(pos.^2,2).^2)./(sum(pos.^4,2));
figure(5); plot(t,R);

%R para energias
E1=(0.5)*m(1)*(vel(:,1)).^2 + (0.5)*k(1)*(pos(:,1)).^2 + (1/4)*k(2)*(pos(:,2)-pos(:,1)).^2;
E2=(0.5)*m(n)*(vel(:,n)).^2 + (0.5)*k(n+1)*(pos(:,n)).^2 + (1/4)*k(n)*(pos(:,n)-pos(:,n-1)).^2;
Em=(0.5)*m(2)*(vel(:,2:n-1)).^2 + (1/4)*k(2:n-1).*(pos(:,2:n-1)-pos(:,1:n-2)).^2 + (1/4)*k(3:n).*(pos(:,3:n)-pos(:,2:n-1)).^2;
Et=[E1, Em, E2];
RE=(sum(Et.^2,2).^2)./(sum(Et.^4,2));
figure(6); plot(t,RE);

ii=1:n;
m1 = sum(ii.*(Et.^2),2)./(sum(Et.^2,2));
m2=  sum(ii.^2.*(Et.^2),2)./(sum(Et.^2,2));

figure(7); plot(t,m1);
figure(8); plot(t,m2);