function result=evolveSnake(I,cOpt,eOpt,iOpt)
% inputs, 
%  I : Gray level image data
%  n : Number of contour points
%  r : Radius of initial contour
%  k,l : Center of initial contour
%  epsilon : Stop condition for edge detector
%  deltaT : Time step
%  alpha, beta, gamma: Energy terms/coefficents
%  filter : The type of image filter/energy field specification to use
%
% outputs,
%  result.cOriginal : Initial contour
%  result.c : Final contour
%  result.gradX, result.gradY : Gradient components
%
% Reference:    Todorov, M. D., Sirakov, N. M., & Suh, S. (2013). 
%               Fast splitting scheme to minimize new energy functional 
%               containing Schröding erequation solution
%               
%               Bowden, Adam
%               Implementation of a Finite Splitting Scheme to Segment
%               Images with the Solution to the Poisson and Schrodinger
%               Equations
% Function was written Spring 2014 by Adam Bowden, GA at TAMU-C
    %profile on;
    maxIterations = 1000;
    n = cOpt.numPts;    
    
    [cols,rows,~]=size(I);

    %img = figure('Name','Contour Evolution','NumberTitle','off');
    ax = findobj(gcf,'type','axes');
    %ax = axes('Parent',img);
    imshow(I,'Parent',ax);
    hold(ax,'all');
    
    I=double(rgb2gray(I));
    
    [c,h] = initContour(cOpt);
    
    cOriginal = c;    
    cNext = c;
    
    %AC = plot(cNext(:,2),cNext(:,1),'-r*','MarkerSize',2,'LineWidth',2,'Parent',ax);
    %pause(0.05);
    
    movePt(1:n) = 1; %Array to stop movement
    
    [potentialField,edges] = createPotentialField(I,cols,rows,iOpt.filter,iOpt.fSize);
    if(~potentialField)
        result = 'Invalid field type detected!';
        return
    end
    
    [dx,dy]=gradient(potentialField); %Calculate the potential energy vector field
    
    %Normalize potential gradient field
    gradX=zeros(cols,rows,'double');
    gradY=zeros(cols,rows,'double');
    for i=1:cols
        for j = 1:rows
            if sqrt(dx(i,j)^2+dy(i,j)^2) == 0
                gradX(i,j)=0;
                gradY(i,j)=0;
            else
                gradX(i,j) = dx(i,j)/sqrt(dx(i,j)^2+dy(i,j)^2);
                gradY(i,j) = dy(i,j)/sqrt(dx(i,j)^2+dy(i,j)^2);
            end
        end
    end
    
    cNext = checkBounds(cNext,n,cols,rows);
    initVecInt = lineIntegral(cNext,n,h,gradX,gradY);
    initIntImg = lineIntegralImg(I,cNext,n,h);
    
    A = createMatrix(n,h,iOpt.deltaT,eOpt.alpha,eOpt.gamma,eOpt.beta); %Create coefficient matrix
    
    %Evolve contour
    count = 0;
    cont = 1;
    m=zeros(n,1,'double');
    while cont==1 && count < maxIterations
        cont=0;
        j=1;
        %Initialize column vector
        for i=1:n
            m(j) = c(i,1);
            m(j+1) = c(i,2);
            j=j+2;
        end
        sol = A\m; %Solve for the half time step
               
        %Round off coordinates to the nearest neighbor
        C(:,1) = round(sol(1:2:2*n-1));
        C(:,2) = round(sol(2:2:2*n));
        
        C = checkBounds(C,n,cols,rows);
               
        %cPrev(:,1) = round(cNext(1:2:2*n-1));
        %cPrev(:,2) = round(cNext(2:2:2*n));
        
        for i = 1:n
           if movePt(i)
               %gxy = checkForEdge(cPrev(i,1),cPrev(i,2),edges,iOpt.epsilon);
               
               gxy = checkForEdge(C(i,1),C(i,2),edges,iOpt.epsilon);
               cNext(i,1) = C(i,1) + (iOpt.deltaT/eOpt.gamma)*gradY(C(i,1),C(i,2))*gxy;
               cNext(i,2) = C(i,2) + (iOpt.deltaT/eOpt.gamma)*gradX(C(i,1),C(i,2))*gxy;
               movePt(i) = gxy;
               if(gxy)
                   cont = 1;
               end
           end
        end
        
        cNext = checkBounds(cNext,n,cols,rows);       
        
        %delete(AC);
        
        %AC = plot(cNext(:,2),cNext(:,1),'-r*','MarkerSize',2,'LineWidth',2,'Parent',ax);
        %pause(0.05);
        
        c = cNext;
        count = count+1;
    end      
     
    finalIntegral = lineIntegral(cNext,n,h,gradX,gradY);
    finalIntegralImg = lineIntegralImg(I,cNext,n,h);
    integrals = struct('initVecInt',initVecInt,'initIntImg',initIntImg,'finalIntegral',finalIntegral,'finalIntegralImg',finalIntegralImg);
    
    %delete(AC);
        
    %AC = plot(cNext(:,2),cNext(:,1),'-r*','MarkerSize',2,'LineWidth',2,'Parent',ax);
    %pause(0.05);
    
    %delete(AC);
    
    cNext(:) = round(cNext(:));
    if((cOpt.split || cOpt.split_dist) && cOpt.connect)
        cNext = removePts(cNext,n,edges,iOpt.epsilon,cOpt.dist);
        cNext = addPts(cNext,I,edges,iOpt.epsilon); 
    elseif(cOpt.split || cOpt.split_dist)
        cNext = removePts(cNext,n,edges,iOpt.epsilon,cOpt.dist);      
    else
        cNew = struct('cNum',[],'x',[],'y',[]);
        cNew(1).x = C(:,1);
        cNew(1).y = C(:,2);
        cNext = cNew;
    end
    cOriginal(:,:) = round(cOriginal(:,:));
    
    potentialField = normalize(potentialField,0,255);
    
    %profile viewer;
    result = struct('cOriginal',cOriginal,'c',cNext,'gradX',gradX,'gradY',gradY,'integrals',integrals,'potential',potentialField);
end