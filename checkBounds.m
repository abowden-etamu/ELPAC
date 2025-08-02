function contour = checkBounds( c,n,cols,rows )
    
    for i=1:n
       if c(i,1)<1
          c(i,1)=1; 
       end
       if c(i,1)>cols
          c(i,1)=cols;
       end
       if c(i,2)<1
          c(i,2)=1; 
       end
       if c(i,2)>rows
          c(i,2)=rows;
       end       
    end    
    
    contour = c;
end

