function z = testVector( fName )

    if(isempty(fName))
        filename = uigetfile;
    else
        filename = fName;
    end
    
    I_color = imread(filename);
    I=double(rgb2gray(imread(filename)));        
            
    [rows,cols,~]=size(I);
    
    [dx,dy]=gradient(I);
    
    for i=1:rows
        for j = 1:cols
            if sqrt(dx(i,j)^2+dy(i,j)^2) == 0
                gradX(i,j)=0;
                gradY(i,j)=0;
            else
                gradX(i,j) = dx(i,j)/sqrt(dx(i,j)^2+dy(i,j)^2);
                gradY(i,j) = dy(i,j)/sqrt(dx(i,j)^2+dy(i,j)^2);
            end
        end
    end
        
    imgPlot2 = figure('Name','GradientTest2','NumberTitle','off');
    imgAxes2 = axes('Parent',imgPlot2);
    imshow(uint8(I_color),'Parent',imgAxes2);
    hold(imgAxes2,'all');    
    [x,y] = meshgrid(1:cols,1:rows);
    u = gradX;
    v = gradY;   
    quiver(x,y,u,v);
    hold on;    
    
    for i=1:rows
        for j=1:cols
            absGradI(i,j)=dx(i,j)^2+dy(i,j)^2;
        end
    end
    
    Ifilter = poisson(absGradI);

    Ifilter = normalize(Ifilter,0,255);
    
    [dx_poisson,dy_poisson]=gradient(Ifilter);
    
    for i=1:rows
        for j = 1:cols
            if sqrt(dx(i,j)^2+dy(i,j)^2) == 0
                gradX(i,j)=0;
                gradY(i,j)=0;
            else
                gradX(i,j) = dx_poisson(i,j)/sqrt(dx_poisson(i,j)^2+dy_poisson(i,j)^2);
                gradY(i,j) = dy_poisson(i,j)/sqrt(dx_poisson(i,j)^2+dy_poisson(i,j)^2);
            end
        end
    end
  
    imgPlot = figure('Name','GradientTest','NumberTitle','off');
    imgAxes = axes('Parent',imgPlot);
    imshow(uint8(I),'Parent',imgAxes);
    hold(imgAxes,'all');    
    [x,y] = meshgrid(1:cols,1:rows);
    u = gradX;
    v = gradY;   
    quiver(x,y,u,v);
    hold on;    
     
    z = 'Done!';

end

