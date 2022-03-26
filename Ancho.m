function f=Ancho(Cnts,punto)
 x2=Cnts(2)+Cnts(3)*sqrt(log(Cnts(1)/punto)); 
 x1=Cnts(2)-Cnts(3)*sqrt(log(Cnts(1)/punto));
 
 f=[x1,x2,abs(x2-x1)]; 
end  