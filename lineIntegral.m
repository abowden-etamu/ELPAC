function q = lineIntegral(cNext,n,h,gradX,gradY) 

    cPrime = zeros(n);
    for i=0:n-1
        cPrime(i+1,1) = ( cNext(mod(i+1,n)+1,1) - cNext(mod(i,n)+1,1) ) / h;
        cPrime(i+1,2) = ( cNext(mod(i+1,n)+1,2) - cNext(mod(i,n)+1,2) ) / h;
    end
   
    dotProduct = zeros(n,1);
    for i=1:n
        F = [gradX(round(cNext(i))),gradY(round(cNext(i)))];
        rPrime = [cPrime(i,1),cPrime(i,2)];
        dotProduct(i) = dot(F,rPrime);
    end
    
    q = integral(@(x) interp1(dotProduct, x),1,n);
end