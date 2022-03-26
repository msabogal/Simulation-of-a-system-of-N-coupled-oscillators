clear all; 
dx=1d-2; dy=dx; x=-10:dx:10; y=x; 
A=exp(-x.^2); 
s_total=sum(A)*dx; 
s_fwhm=sum(A(A>=0.5))*dx; p_fwhm=s_fwhm/s_total*100;
s_1e=sum(A(A>=(1/exp(1))))*dx; p_1e=s_1e/s_total*100; 
s_2e=sum(A(A>=(1/exp(2))))*dx; p_2e=s_2e/s_total*100; 

[X,Y]=meshgrid(x,y); 
A=exp(-(X.^2+Y.^2)); 

s_total_2=sum(sum(A))*dx*dy; 
s_fwhm_2=sum(sum(A(A>=0.5)))*dx*dy; p_fwhm_2=s_fwhm_2/s_total_2*100;
s_1e_2=sum(sum(A(A>=(1/exp(1)))))*dx*dy; p_1e_2=s_1e_2/s_total_2*100; 
s_2e_2=sum(sum(A(A>=(1/exp(2)))))*dx*dy; p_2e_2=s_2e_2/s_total_2*100; 

