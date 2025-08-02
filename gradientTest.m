function z = gradientTest(fName)

    if(isempty(fName))
        filename = uigetfile;
    else
        filename = fName;
    end
    
    I=double(rgb2gray(imread(filename)));        
            
    [rows,cols,~]=size(I);
    %sigma=.5;
    %p=1;
    %k=1;
    %n=2*p+1;
    %m=2*k+1;
    
    %i=-p:1:p;
    %j=-k:1:k;
    
    %for ii=1:n
    %    for jj=1:m
    %        filter(ii,jj)=cosh(sigma*sqrt((i(ii))^2+(j(jj))^2));
    %    end
    %end
    
    %filter = fspecial('gaussian',10,2);
    %Ifilter = imfilter(I,filter);
    %Ifilter = normalize(Ifilter,0,255);
    
    Ifilter = schrodingerFilter(I,3,3);
    Ifilter = normalize(Ifilter,0,255);
    %fltr = fspecial('gaussian',[3,3],1);
    
    
    %Ifilter = imfilter(I,fltr);
    %Ifilter = normalize(Ifilter,0,255);
    %I = edge(I,'canny');
    %imshow(I);
    %return
    [dx,dy]=gradient(Ifilter);
    
    %absGradI=divergence(dx,dy);
    
    for i=1:rows
        for j=1:cols
            absGradI(i,j)=dx(i,j)^2+dy(i,j)^2;
        end
    end
    %absGradI=divergence(dx,dy);
    %Ifilter=divergence(dx,dy)
    Ifilter =absGradI;
    %Ifilter = poisson(absGradI);
    
    %absGradI = -poisson(I);
    %Ifilter = normalize(absGradI,0,255);
    %imshow(uint8(absGradI));
    %return
    %Ifilter = poisson(I);
    %Ifilter = poisson(absGradI);
    
    %h = fspecial('laplacian');
    %Ifilter = imfilter(I,h);
    
    %Ifilter = laplace(I);
    Ifilter = normalize(Ifilter,0,255);
    %Ifilter = poisson(Ifilter);
    imshow(uint8(Ifilter));
    
    [dx,dy]=gradient(Ifilter);
    
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
    imgPlot = figure('Name','Energy','NumberTitle','off');
    imgAxes2 = axes('Parent',imgPlot);
    plot3d
    imshow(uint8(Ifilter),'Parent',imgAxes2);
    [x y] = meshgrid(2:cols-1,2:rows-1);
    imgPlot = figure('Name','GradientTest','NumberTitle','off');
    imgAxes = axes('Parent',imgPlot);
    imshow(uint8(I),'Parent',imgAxes);
    hold(imgAxes,'all');
    [x,y] = meshgrid(1:cols,1:rows);
    u = gradX;
    v = gradY;   
    quiver(x,y,u,v);
    hold on;
    
    %mesh(x,y,Ifilter(2:rows-1,2:cols-1));
    %return;
    
    %u = dx;
    %v = dy;
    
    %u = gradX;
    %v = gradY;
    
    %quiver(x,y,u,v);
    
    %v=1:1:rows;
    %u=1:1:cols;
    %quiver(v,u,gradIx,gradIy);
    %quiver(v,u,normalGradIx,normalGradIy);
    %imshow(uint8(absGradI));
    %imshowpair(gMag,imgProcessed,'montage');
    
    z = 'Done!';

end