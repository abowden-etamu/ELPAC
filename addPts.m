function c = addPts(C,I,edges,epsilon)
    [~,numC] = size(C);
    
    ax = findobj(gcf,'type','axes');
    hold(ax,'all');

    %for con = 1:numC
    %    AC(con) = plot(C(1,con).y,C(1,con).x,'-r*','MarkerSize',2,'LineWidth',2,'Parent',ax);
    %end
    %pause(0.05);
    %for con = 1:numC
    %    delete(AC(con));
    %end
    
    i = 1;
    while i <= numC
       [~,numPts] = size(C(i).x);
       jj = 1;
       deleteP = 0;
       cReplace = 0;
                    
       while jj < numPts
           kk = jj+1;
           mm = 1;
           while kk <= numPts && C(i).x(jj) == C(i).x(kk) && C(i).y(jj) == C(i).y(kk)
                deleteP(mm) = kk;
                %C(i).x(kk) = [];
                %C(i).y(kk) = [];
                kk = kk + 1;
                mm = mm + 1;
           end
           [~,toDelete] = size(deleteP);
           if deleteP ~= 0
                for ll = 1:toDelete
                    C(i).x(deleteP(ll)) = -1;
                end
                nn = 1;
                qq = 1;
                while nn <= numPts
                    if C(i).x(nn) ~= -1
                        cReplace(1,qq) = C(i).x(nn);
                        cReplace(2,qq) = C(i).y(nn);
                        qq = qq + 1;
                    end
                    nn = nn + 1;
                end
                C(i).x = cReplace(1,:);
                C(i).y = cReplace(2,:);
           end
           deleteP = [];
           cReplace = [];
           jj = jj + 1;
           [~,numPts] = size(C(i).x);
       end
       if(numPts) > 1
            C(i).x(numPts) = [];
            C(i).y(numPts) = [];
       end
       [~,numPts] = size(C(i).x);
       if numPts <= 2
          C(i) = []; 
          numC = numC - 1;
          i = i - 1;
       end
       i = i+1;
    end
    
%    for i = 1:numC
%        [~,numPts] = size(C(i).x);
        
%        C_unique = cat(2,transpose(C(i).x),transpose(C(i).y));
%        C_unique = unique(C_unique,'rows');
%        C(i).x = transpose(C_unique(:,1));
%        C(i).y = transpose(C_unique(:,2));
%    end       
    
    [cols,rows,~]=size(I);
    
    wSize = 3;
    k = 1;
    
    [gY,gX] = gradient(edges);
    
    for i=1:cols
        for j = 1:rows
            if sqrt(gX(i,j)^2+gY(i,j)^2) == 0
                gX(i,j)=0;
                gY(i,j)=0;
            else
                gX(i,j) = gX(i,j)/sqrt(gX(i,j)^2+gY(i,j)^2);
                gY(i,j) = gY(i,j)/sqrt(gX(i,j)^2+gY(i,j)^2);
            end
        end
    end
    
    cExist(1:numC) = 1;
    cNew = struct('cNum',[],'x',[],'y',[]);
    iter = 0;
    for i = 1:numC
        iter = 0;
        if(cExist(i))
            %firstPt(1) = C(i).x(1);
            %firstPt(2) = C(i).y(1);
            %[~,numPts] = size(C(i).x);  
            
            %firstPt = [C(i).x(numPts),C(i).y(numPts)];
            
            cNew(k).x = C(i).x;
            cNew(k).y = C(i).y;
            
            AC2(k) = plot(cNew(1,k).y,cNew(1,k).x,'-r*','MarkerSize',2,'LineWidth',2,'Parent',ax);
            
            [~,numPts] = size(C(i).x);
            
            %cNew(k).x(1:2) = C(i).x(1:2);
            %cNew(k).y(1:2) = C(i).y(1:2);
            
            next = nextPt(cNew,C,i,cExist,I,wSize,edges,epsilon,gX,gY,iter,numPts);
            iter = iter + 1;
            %cNew(k) = C(i);
            while( (~((next(1) == cNew(k).x(1)) && (next(2) == cNew(k).y(1))))  )
                delete(AC2(k));
                [~,numPts] = size(cNew(k).x);
                
                [~,sizeNew] = size(next);
                
                if(sizeNew>2)
                    cNew(k).x(numPts+1:numPts+sizeNew) = next(1,:);
                    cNew(k).y(numPts+1:numPts+sizeNew) = next(2,:);
                    cExist(next(3,1)) = 0;
                else    
                    cNew(k).x(numPts+1)=next(1);
                    cNew(k).y(numPts+1)=next(2);
                end
                
                [~,numPts] = size(cNew(k).x);
                
                next = nextPt(cNew(k),C,i,cExist,I,wSize,edges,epsilon,gX,gY,iter,numPts);
                iter = iter + 1;
                
                ax = findobj(gcf,'type','axes');
                hold(ax,'all');
                
                
                %AC2(k) = plot(cNew(1,k).y,cNew(1,k).x,'-r*','MarkerSize',2,'LineWidth',2,'Parent',ax);
                %pause(0.0001);
                
                %for con = 1:size(cNew)
                %    delete(AC(con));
                %end
            end
            %cNew(k).x(j+1) = firstPt(1);
            %cNew(k).y(j+1) = firstPt(2);
            k = k+1;
        end
    end    
    c = cNew;
end

