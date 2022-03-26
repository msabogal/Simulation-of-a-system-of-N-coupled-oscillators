function f=sistemaqn(x,wo,omega,zi,la)
a= -la*(omega.^2); b= (wo.^2 -omega.^2); c=-(3/4)*zi* wo.^6; 

W3= b.*ones(1,length(x)) + c*(x.^2); W1= a*ones(1,length(x)-1); 

M=diag(W1,1) + diag(W3,0) + diag(W1,-1);

f=M*x(:); 
end