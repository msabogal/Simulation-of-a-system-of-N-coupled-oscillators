function F= propagarSn(t,x,zi,wn,la)
N=length(x)/2; 

l0=ones(1,N); %% Diagonal de unos 
lal1=la*ones(1,N-1); %%% Diagonales de landas 
M1= diag(l0,0) + diag(lal1,1) + diag(lal1,-1); %% Matriz 1
M1inv= inv(M1);  %%% Inversa de 1
%%%
a=-1* wn.^2 + (zi*wn.^6)*x(1:N).^2; %%% Diagonal de M2
M2=diag(a,0); %%% Matriz de M2
%%%
M3=M1inv*M2; %M3

iden=eye(N); cero=zeros(N); %%% Las matriz zeros y identidad 
%Matrices de las EDO
M=[cero,iden;M3,cero]; %%% Matriz total para propagar 
F=M*x; %%% Propagacion 
end