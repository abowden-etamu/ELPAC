function contour = removePts(C,n,edges,epsilon,dist)
    cNew = struct('cNum',[],'x',[],'y',[]);

    j=1;
    k=1;
    notFar = 1;
    for i=1:n
        onEdge = ~checkForEdge(C(i,1),C(i,2),edges,epsilon);
        if(i>1) 
            notFar = sqrt( ( C(i,1)-C(i-1,1) )^2 + ( C(i,2)-C(i-1,2) )^2 ) < dist;
        end
        if onEdge && notFar
            cNew(k).x(j) = C(i,1);
            cNew(k).y(j) = C(i,2);
            j=j+1;
        elseif i < n
            i=i+1;
            onEdge = ~checkForEdge(C(i,1),C(i,2),edges,epsilon);
            if(i>1)
                notFar = sqrt( ( C(i,1)-C(i-1,1) )^2 + ( C(i,2)-C(i-1,2) )^2 ) < dist;
            end
            while (~onEdge || ~notFar) && i < n
                i=i+1;
                onEdge = ~checkForEdge(C(i,1),C(i,2),edges,epsilon);
                if(i>1)
                    notFar = sqrt( ( C(i,1)-C(i-1,1) )^2 + ( C(i,2)-C(i-1,2) )^2 ) < dist;
                end
            end
            if onEdge && notFar
                k=k+1;
                j=1;
                cNew(k).x(j) = C(i,1);
                cNew(k).y(j) = C(i,2);
                j=j+1;
            end
        end
    end
    
    contour = cNew;
end

