function [potentialField,edges] = createPotentialField(I,cols, rows,filter,fSize)
    fieldType = filter.fieldType;
    stopType = filter.stopType;    
        
    ImgFilter = schrodingerFilter(I,fSize,fSize);
    ImgFilter = normalize(ImgFilter,0,255);
    absGradIfilter=zeros(cols,rows,'double');
    
    switch fieldType
        case 'gradient'
            %absGradI=zeros(cols,rows,'double');
            %[dx,dy]=gradient(ImgFilter);    
            %for i=1:cols
            %    for j=1:rows
            %        absGradI(i,j)=(dx(i,j)^2+dy(i,j)^2);
            %    end
            %end
            potentialField = poisson(ImgFilter); %Find the Poisson potential field
        case 'laplacian'
            filter = fspecial('laplacian');
            iFilter = imfilter(ImgFilter,filter);
            iFilter = normalize(iFilter,0,255);
            potentialField = poisson(iFilter);            
        case 'schrodinger'
            potentialField = schrodingerFilter(I,3,3);
        case 'gaussian'
            filter = fspecial('gaussian',4,1);
            potentialField = imfilter(I,filter);
        otherwise
            potentialField = FALSE;
    end
    
    switch stopType
        case 'Gradient'
            [dx,dy]=gradient(ImgFilter);    
            for i=1:cols
                for j=1:rows
                    absGradIfilter(i,j)=(dx(i,j)^2+dy(i,j)^2);
                end
            end
            edges = absGradIfilter;
        case 'Laplacian'
            filter = fspecial('laplacian');
            iFilter = imfilter(ImgFilter,filter);
            iFilter = normalize(iFilter,0,255);
            [dx,dy]=gradient(iFilter);
            for i=1:cols
                for j=1:rows
                    absGradIfilter(i,j)=(dx(i,j)^2+dy(i,j)^2);
                end
            end
            edges = absGradIfilter;
    end
end

