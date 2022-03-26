function f=prim(a,b,c)
a=2*a; b=b/2; c= c^c; 
k=0; 
for i=1:a
    k=k + a+b+c; 
end

f=[a,b,c,k]; 
end