function f=solveqn(omega,x0,wn,zi,la)
x01=x0; x02=x0; qn1=[]; con=[] ; qn2=[]; con2=[] ; 

options = optimoptions('fsolve','Display','off');

for i=1:length(omega)
    fun=@(x) sistemaqn(x,wn,omega(i),zi,la) ; [xx,yy]=fsolve(fun,x01,options); 
    qn1=[qn1;xx]                            ;  con=[con;sum(yy.^2)];         x01=[qn1(i,:)];
    
    fun2=@(x) sistemaqn(x,wn,-omega(i),zi,la) ; [xx2,yy2]=fsolve(fun2,x02,options); 
    qn2=[qn2;xx2]                            ;  con2=[con2;sum(yy2.^2)];         x02=[qn2(i,:)];
end

f= [flipud(qn2);qn1]; 
end 