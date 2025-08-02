function next = nextPt(C,cOld,cCount,cExist,I,wSize,edges,epsilon,gX,gY,iter,p)
    Pt = [];
    maxChg = 0;
    
    [height,width,~] = size(I);
    
    if(p == 2)
        next = [C.x(1),C.y(1)];
        return;
    end
    
    if(iter > 5000)

    end
    
    [~,nc] = size(C);
    C = C(nc);
    [~,numPts] = size(C.x);
    edgeGrid = zeros(3,3);

    for m = 1:3
        for n = 1:3
            x = C.x(p) + (m-2);
            y = C.y(p) + (n-2);

            if(iter > 1 && x == C.x(1) && y == C.y(1))
                next = [C.x(1),C.y(1)];
                return;
            end
            
            [~,np] = size(cOld);
            for cntr = 1:np
                if cntr == cCount || ~cExist(cntr)
                    continue;
                end
                [~,numCntrPts] = size(cOld(cntr).x);
                
                if( x == cOld(cntr).x(1) && y == cOld(cntr).y(1) )
                    if(numCntrPts > 3 && cOld(cntr).x(numCntrPts-2) == cOld(cntr).x(numCntrPts) && cOld(cntr).y(numCntrPts-2) == cOld(cntr).y(numCntrPts))
                        cOld(cntr).x(numCntrPts) = [];
                        cOld(cntr).y(numCntrPts) = [];
                        numCntrPts = numCntrPts - 1;
                    end
                    for ii = 1:numCntrPts
                        next(1,ii) = cOld(cntr).x(ii);
                        next(2,ii) = cOld(cntr).y(ii);
                        next(3,1) = cntr;
                    end
                    return;
                end
                if( x == cOld(cntr).x(numCntrPts) && y == cOld(cntr).y(numCntrPts) )
                    if(numCntrPts > 3 && cOld(cntr).x(1) == cOld(cntr).x(3) && cOld(cntr).y(1) == cOld(cntr).y(3))
                        cOld(cntr).x(1) = [];
                        cOld(cntr).y(1) = [];
                        numCntrPts = numCntrPts - 1;
                    end
                    for ii = numCntrPts:-1:1
                        next(1,ii) = cOld(cntr).x(ii);
                        next(2,ii) = cOld(cntr).y(ii);
                        next(3,1) = cntr;
                    end                    
                    return;
                end
            end
            
            if((x > 0 && y > 0) && (x < height && y < width))
                edgeGrid(m,n) = ~checkForEdge(x,y,edges,epsilon);
            end
            
            for i=2:numPts
                if((x == C.x(i)) && (y == C.y(i)))
                    edgeGrid(m,n) = 0;
                    break;
                end
            end
            
            %{
            edgeGrid(m,n) = edges(x,y);

            for i=2:numPts
                if((x == C.x(i)) && (y == C.y(i)))
                    edgeGrid(m,n) = -1;
                    break;
                end
            end
            %}
        end
    end

    if(p>1)
        dx = C.x(p) - C.x(p - 1);
        dy = C.y(p) - C.y(p - 1);
    else
        dx = gX(C.x(p),C.y(p));
        dy = gY(C.x(p),C.y(p));
    end
          
    x = round(C.x(p)+gX(C.x(p),C.y(p)));
    y = round(C.y(p)+gY(C.x(p),C.y(p)));
    
    sideOfLine = F(C.x(p - 1),C.y(p - 1),C.x(p),C.y(p),x,y);
    
    countBck = 1;
    while(sideOfLine == 0 && countBck < (p - 1))
        x = round(C.x(p - countBck)+gX(C.x(p - countBck),C.y(p - countBck)));
        y = round(C.y(p - countBck)+gY(C.x(p - countBck),C.y(p - countBck)));
        
        sideOfLine = F(C.x(p - countBck - 1),C.y(p - countBck - 1),C.x(p - countBck),C.y(p - countBck),x,y);
        
        countBck = countBck + 1;
    end
    
    if(countBck == (p-1))
        sideOfLine = 1;
    end
    
    if(sideOfLine > 0)    
        if(dx < 0 && dy > 0)      
           for m = 3:-1:1
                if(edgeGrid(m,3))
                %if(edgeGrid(m,3) > 0 &&edgeGrid(m,3) >= maxChg) 
                    %maxChg = edgeGrid(m,3); 
                    Pt = [C.x(p) + (m-2),C.y(p) + 1];
                end
            end   
            for n = 2:-1:1
                if(edgeGrid(1,n))
                %if(edgeGrid(1,n) > 0 && edgeGrid(1,n) >= maxChg) 
                    %maxChg = edgeGrid(1,n);
                    Pt = [C.x(p) - 1,C.y(p) + (n-2)];
                end
            end     
        elseif(dx > 0 && dy < 0)
            for m = 3:-1:1
                if(edgeGrid(m,1))
                %if(edgeGrid(m,1) > 0 && edgeGrid(m,1) >= maxChg)
                    %maxChg = edgeGrid(m,1);
                    Pt = [C.x(p) + (m-2),C.y(p) - 1];
                end
            end  
            for n = 3:-1:2
                if(edgeGrid(3,n))
                %if(edgeGrid(3,n) && edgeGrid(3,n) >= maxChg)
                    %maxChg = edgeGrid(3,n);
                    Pt = [C.x(p) + 1,C.y(p) + (n-2)];
                end
            end
        elseif(dx > 0 && dy > 0)
            for n = 1:3
                if(edgeGrid(3,n))
                %if(edgeGrid(m,3) > 0 && edgeGrid(m,3) >= maxChg)
                    %maxChg = edgeGrid(m,3);
                    Pt = [C.x(p) + 1,C.y(p) + (n-2)];
                end
            end
            for m = 2:-1:1
                if(edgeGrid(m,3))
                %if(edgeGrid(3,n) > 0 && edgeGrid(3,n) >= maxChg)
                    %maxChg = edgeGrid(3,n);
                    Pt = [C.x(p) + (m-2),C.y(p) + 1];
                end
            end 
        elseif(dx < 0 && dy < 0)
            for m = 3:-1:2
                if(edgeGrid(m,1))
                %if(edgeGrid(m,1) > 0 && edgeGrid(m,1) >= maxChg)
                    %maxChg = edgeGrid(m,1);
                    Pt = [C.x(p) + (m-2),C.y(p) - 1];
                end
            end
            for n = 1:3
                if(edgeGrid(1,n))
                %if(edgeGrid(1,n) > 0 && edgeGrid(1,n) >= maxChg)
                    %maxChg = edgeGrid(1,n);
                    Pt = [C.x(p) - 1,C.y(p) + (n-2)];
                end
            end           
        elseif(dy == 0 && dx > 0)
            %{
            for n=3:-1:1
                if(edgeGrid(2,n) > 0 && edgeGrid(2,n) >= maxChg)
                    maxChg = edgeGrid(2,n);
                    Pt = [C.x(p),C.y(p) + (n-2)];
                end
            end
            %}
            for n=3:-1:1
                if(edgeGrid(3,n))
                %if(edgeGrid(3,n) > 0 && edgeGrid(3,n) >= maxChg)
                    %maxChg = edgeGrid(3,n);
                    Pt = [C.x(p) + 1,C.y(p) + (n-2)];
                end
            end       
        elseif(dy == 0 && dx < 0)
            %{
            for n=1:3
                if(edgeGrid(2,n) > 0 && edgeGrid(2,n) >= maxChg)
                    maxChg = edgeGrid(2,n);
                    Pt = [C.x(p),C.y(p) + (n-2)];
                end
            end
            %}
            for n=1:3
                if(edgeGrid(1,n))
                %if(edgeGrid(1,n) > 0 && edgeGrid(1,n) >= maxChg)
                    %maxChg = edgeGrid(1,n);
                    Pt = [C.x(p) - 1,C.y(p) + (n-2)];
                end
            end      

        elseif(dx == 0 && dy < 0)
            %{
            for m=3:-1:1
                if(edgeGrid(m,2) > 0 && edgeGrid(m,2) >= maxChg)
                    maxChg = edgeGrid(m,2);
                    Pt = [C.x(p) + (m-2),C.y(p)];
                end
            end
            %}
            for m=3:-1:1
                if(edgeGrid(m,1))
                %if(edgeGrid(m,1) > 0 && edgeGrid(m,1) >= maxChg)
                    %maxChg = edgeGrid(m,1);
                    Pt = [C.x(p) + (m-2),C.y(p) - 1];
                end
            end   

        elseif(dx == 0 && dy > 0)
            %{
            for m=1:3
                if(edgeGrid(m,2) > 0 && edgeGrid(m,2) >= maxChg)
                    maxChg = edgeGrid(m,2);
                    Pt = [C.x(p) + (m-2),C.y(p)];
                end
            end
            %}
            for m=1:3
                if(edgeGrid(m,3))
                %if(edgeGrid(m,3) > 0 && edgeGrid(m,3) >= maxChg)
                    %maxChg = edgeGrid(m,3);
                    Pt = [C.x(p) + (m-2),C.y(p) + 1];
                end
            end          
        end
    end
   
    
    
    if(sideOfLine < 0)    
        if(dx < 0 && dy > 0)     
            for m = 3:-1:2
                if(edgeGrid(m,3))
                %if(edgeGrid(m,3) > 0 &&edgeGrid(m,3) >= maxChg) 
                    %maxChg = edgeGrid(m,3); 
                    Pt = [C.x(p) + (m-2),C.y(p) + 1];
                end
            end     
            for n = 3:-1:1
                if(edgeGrid(1,n))
                %if(edgeGrid(1,n) > 0 && edgeGrid(1,n) >= maxChg) 
                    %maxChg = edgeGrid(1,n);
                    Pt = [C.x(p) - 1,C.y(p) + (n-2)];
                end
            end
   
        elseif(dx > 0 && dy < 0)
            for m = 1:2
                if(edgeGrid(m,1))
                %if(edgeGrid(m,1) > 0 && edgeGrid(m,1) >= maxChg)
                    %maxChg = edgeGrid(m,1);
                    Pt = [C.x(p) + (m-2),C.y(p) - 1];
                end
            end  
            for n = 1:3
                if(edgeGrid(3,n))
                %if(edgeGrid(3,n) && edgeGrid(3,n) >= maxChg)
                    %maxChg = edgeGrid(3,n);
                    Pt = [C.x(p) + 1,C.y(p) + (n-2)];
                end
            end
      
        elseif(dx > 0 && dy > 0)
            for n = 1:2
                if(edgeGrid(3,n))
                %if(edgeGrid(3,n) > 0 && edgeGrid(3,n) >= maxChg)
                    %maxChg = edgeGrid(3,n);
                    Pt = [C.x(p) + 1,C.y(p) + (n-2)];
                end
            end  
            for m = 3:-1:1
                if(edgeGrid(m,3))
                %if(edgeGrid(m,3) > 0 && edgeGrid(m,3) >= maxChg)
                    %maxChg = edgeGrid(m,3);
                    Pt = [C.x(p) + (m-2),C.y(p) + 1];
                end
            end
        elseif(dx < 0 && dy < 0)
            for n = 3:-1:2
                if(edgeGrid(1,n))
                %if(edgeGrid(1,n) > 0 && edgeGrid(1,n) >= maxChg)
                    %maxChg = edgeGrid(1,n);
                    Pt = [C.x(p) - 1,C.y(p) + (n-2)];
                end
            end
            for m = 1:3
                if(edgeGrid(m,1))
                %if(edgeGrid(m,1) > 0 && edgeGrid(m,1) >= maxChg)
                    %maxChg = edgeGrid(m,1);
                    Pt = [C.x(p) + (m-2),C.y(p) - 1];
                end
            end
        elseif(dy == 0 && dx > 0)
            %{
            for n=3:-1:1
                if(edgeGrid(2,n) > 0 && edgeGrid(2,n) >= maxChg)
                    maxChg = edgeGrid(2,n);
                    Pt = [C.x(p),C.y(p) + (n-2)];
                end
            end
            %}
            for n=1:3
                if(edgeGrid(3,n))
                %if(edgeGrid(3,n) > 0 && edgeGrid(3,n) >= maxChg)
                    %maxChg = edgeGrid(3,n);
                    Pt = [C.x(p) + 1,C.y(p) + (n-2)];
                end
            end       
        elseif(dy == 0 && dx < 0)
            %{
            for n=1:3
                if(edgeGrid(2,n) > 0 && edgeGrid(2,n) >= maxChg)
                    maxChg = edgeGrid(2,n);
                    Pt = [C.x(p),C.y(p) + (n-2)];
                end
            end
            %}
            for n=3:-1:1
                if(edgeGrid(2,n))
                %if(edgeGrid(1,n) > 0 && edgeGrid(1,n) >= maxChg)
                    %maxChg = edgeGrid(1,n);
                    %Pt = [C.x(p) - 1,C.y(p) + (n-2)];
                    Pt = [C.x(p),C.y(p) + (n-2)];
                end
            end   
            for n=3:-1:1
                if(edgeGrid(1,n))
                %if(edgeGrid(1,n) > 0 && edgeGrid(1,n) >= maxChg)
                    %maxChg = edgeGrid(1,n);
                    Pt = [C.x(p) - 1,C.y(p) + (n-2)];
                end
            end      

        elseif(dx == 0 && dy < 0)
            %{
            for m=3:-1:1
                if(edgeGrid(m,2) > 0 && edgeGrid(m,2) >= maxChg)
                    maxChg = edgeGrid(m,2);
                    Pt = [C.x(p) + (m-2),C.y(p)];
                end
            end
            %}
            for m=1:3
                if(edgeGrid(m,1))
                %if(edgeGrid(m,1) > 0 && edgeGrid(m,1) >= maxChg)
                    %maxChg = edgeGrid(m,1);
                    Pt = [C.x(p) + (m-2),C.y(p) - 1];
                end
            end   

        elseif(dx == 0 && dy > 0)
            %{
            for m=1:3
                if(edgeGrid(m,2) > 0 && edgeGrid(m,2) >= maxChg)
                    maxChg = edgeGrid(m,2);
                    Pt = [C.x(p) + (m-2),C.y(p)];
                end
            end
            %}
            for m=3:-1:1
                if(edgeGrid(m,3))
                %if(edgeGrid(m,3) > 0 && edgeGrid(m,3) >= maxChg)
                    %maxChg = edgeGrid(m,3);
                    Pt = [C.x(p) + (m-2),C.y(p) + 1];
                end
            end          
        end
    end
    
        
    if(isempty(Pt))
       next = nextPt(C,cOld,cCount,cExist,I,wSize,edges,epsilon,gX,gY,iter,p-1);
       %nextPt = [C.x(1),C.y(1)];
    else
       next = Pt;
    end
end

function f = F(x_1,y_1,x_2,y_2,x,y)
    f = -(y_2 - y_1)*x + (x_2 - x_1)*y + (y_2 - y_1)*x_2 - (x_2 - x_1)*y_2;
end