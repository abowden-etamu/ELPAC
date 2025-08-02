function [contour,spaceStep] = initContour(cOpt)
    [r,n] = deal(cOpt.radius,cOpt.numPts);

    h = r*sqrt(2-2*cos((2*pi)/n)); %Space step

    s = 0:(1/n):1-(1/n); %Interval segments
    
    if(strcmp(cOpt.contourType,'circle'))
        c(1:n,1)=r*sin(2*pi*s)+cOpt.x;
        c(1:n,2)=r*cos(2*pi*s)+cOpt.y;
    elseif(strcmp(cOpt.contourType,'ellipse'))
        c(1:n,1)=cOpt.h*sin(2*pi*s)+cOpt.x;
        c(1:n,2)=cOpt.k*cos(2*pi*s)+cOpt.y;
    end
    
    contour = c;
    
    spaceStep = h;

end

