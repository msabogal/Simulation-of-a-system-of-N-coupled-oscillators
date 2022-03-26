function F=sistema(x,wo,omega,zi,landa)
%M=[(wo.^2 - omega.^2),-landa*omega.^2 ;-landa*omega.^2,(wo.^2 - omega.^2)] +[-(3/4)*zi*(wo.^6)*x(1).^2 , 0 ; 0 , -(3/4)*zi*(wo.^6)*x(2).^2]; 
F=[(wo.^2 - omega.^2)*x(1)-(3/4)*zi*(wo.^6)*x(1).^3-landa*omega.^2 *x(2);
    (wo.^2 - omega.^2)*x(2)-(3/4)*zi*(wo.^6)*x(2).^3-landa*omega.^2 *x(1)];      
end 