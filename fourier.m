clc; clear all; close all; %Fourier 
N=2^9; x_f=10; x=linspace(-x_f,x_f,N);  

%%% Funcion de estudio %%%%
amplitud=1; sigma=2 ; onda=amplitud*exp(-sigma*(x.^2));  figure(1); plot(x,onda); 

%%% Frecuancias %%%
dx=(2*x_f)/N; n=-N/2:1:N/2; k=2*pi*n/(N*dx); k=k(1:length(k)-1); 

%%% Transformada de Fourier %%%%
transformada=fft(onda); transformada= fftshift(transformada) ; tran_abs= abs(transformada); 

figure(2); plot(k,tran_abs); 

%%%%%%%%%%%% Propagacion %%%%%%%%%%
z=1 ;  factor_propagador= exp(-(1i*(k.^2)*z)/2); 

onda_propagada= transformada.*factor_propagador;

figure(4); hold on  
plot(k,transformada) ;   plot(k,onda_propagada); 

tran_inversa= ifft(ifftshift(onda_propagada)); inversa_abs=abs(tran_inversa); 

%%% Dispersion %%%
figure(5); hold on 
plot(x,onda); plot(x,inversa_abs); 

%%% Potencia (Conservacion de ala energia) %%% 
potencia_inicial= sum(abs(onda).^2)*dx ;  potencia_final=sum(inversa_abs.^2)*dx ; 


%%% Comparar con datos analiticos 
tra_a=amplitud* sqrt(pi/sigma)*exp(-((k).^2)/(4*sigma.^2))  ;

figure(6); hold on
plot(k,tra_a); %plot(f,tran_abs); 


