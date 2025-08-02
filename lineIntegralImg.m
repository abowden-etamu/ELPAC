function q = lineIntegralImg(img,cNext,n,h)

    dx = zeros(n);
    dy = zeros(n);
    for i=0:n-1
        dx(i+1) = ( cNext(mod(i+1,n)+1,1) - cNext(mod(i,n)+1,1) );
        dy(i+1) = ( cNext(mod(i+1,n)+1,2) - cNext(mod(i,n)+1,2) );
    end

    sumLen = 0;
    for i=1:n
       sumLen = sumLen + sqrt(dx(i)^2 + dy(i)^2);
    end
    
    integrand = zeros(n,1);
    for i=1:n
        ds = sqrt(dx(i)^2 + dy(i)^2);
        
        integrand(i) = ( img(round(cNext(i,1)), round(cNext(i,2)))/255 )*ds;
        
        %integrand = normalize(integrand,0,1);
    end
    
    sum = 0;
    for i=1:n
       sum = sum + integrand(i); 
    end
    
    sum = sum / sumLen;
    
    q = sum;
    
    %q = integral(@(x) interp1(integrand, x),1,n);    
end

