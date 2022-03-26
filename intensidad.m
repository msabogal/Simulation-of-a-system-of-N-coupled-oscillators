function f=intensidad(data,punto) 
 I=0;
 for i=1:length(data)
    if data(i) >= punto
        I=I+data(i);
    end    
 end
 
 f=I; 
end 

