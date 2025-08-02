function z = elpac(filename,o)
% inputs, 
%  n : Image filename
%  o : Struct with program options
%       o.Opt : Contour options
%            o.Opt.numPts : Number of contour points
%            o.Opt.radius : Contour radius
%            o.Opt.x, o.Opt.y : Center of contour
%       o.eOptpsilon : Stop condition
%       o.deltaT : Time step
%       o.eOpt : Energy options
%            o.eOpt.gamma, o.eOpt.alpha, o.eOpt.beta : Energy coefficients
%       o.plotC1, o.plotC2, o.plotV : Plotting options
%       o.filter : Image filter / energy field specification
%    
% outputs,
%
% Function was written Spring 2014 by Adam Bowden, GA at TAMU-C
        
    I = imread(filename);
    %I=double(rgb2gray(Icolor));
    result = evolveSnake(I,o.cOpt,o.eOpt,o.iOpt);

    %Graph, plot, and save plot
    if(ismethod(o,'plot'))
        plotTitle=sprintf('numPts=%g_R=%g_alpha=%s_beta=%s_epsilon=%g_gamma=%g_deltaT=%g_fieldType=%s_fSize=%g_stopType=%s',o.cOpt.numPts,char(o.eOpt.alpha),char(o.eOpt.beta),o.iOpt.epsilon,o.eOpt.gamma,o.iOpt.deltaT,o.iOpt.filter.fieldType,o.iOpt.fSize,o.iOpt.filter.stopType);
        imgPlot = figure('Name',plotTitle,'NumberTitle','off');
        imgAxes = axes('Parent',imgPlot);
        imshow(uint8(Icolor),'Parent',imgAxes);
        hold(imgAxes,'all');

        if o.plot.C1 == true %Plot orginal contour
            plot(result.cOriginal(:,2),result.cOriginal(:,1),'-*g');
        end
        if o.plot.V == true %Plot vector field
            [rows,cols,~]=size(imread(filename));
            [x,y] = meshgrid(1:cols,1:rows);
            u = result.gradX;
            v = result.gradY;
            quiver(x,y,u,v);
        end
        if o.plot.C2 == true %Plot final contour
           plot(result.c(:,2),result.c(:,1),'-*r'); 
        end

        if o.save    
            fNameSplit=strsplit(filename,'.');
            fNameFig=sprintf('%s_%s.fig',fNameSplit{1},datestr(clock,'yyyy-mm-dd_HHMMSS'));
            fNameTxt=sprintf('%s_%s.txt',fNameSplit{1},datestr(clock,'yyyy-mm-dd_HHMMSS'));
            file = fopen(fNameTxt,'w');
            if(strcmp(o.cOpt.contourType,'circle'))
                text = 'Gamma = %g\nAlpha = %s\nBeta = %s\nEpsilon = %g\ndeltaT = %g\nnumPts = %g\nRadius = %g\nx = %g y = %g\nfieldType = %s\nfSize = %g\nstopType=%s';
                fprintf(file,text,o.eOpt.gamma,char(o.eOpt.alpha),char(o.eOpt.beta),o.iOpt.epsilon,o.iOpt.deltaT,o.cOpt.numPts,o.cOpt.radius,o.cOpt.x,o.cOpt.y,o.iOpt.filter.fieldType,o.iOpt.fSize,o.iOpt.filter.stopType);
                fclose(file);
            elseif(strcmp(o.cOpt.contourType,'ellipse'))
                text = 'Gamma = %g\nAlpha = %s\nBeta = %s\nEpsilon = %g\ndeltaT = %g\nnumPts = %g\nx = %g y = %g\nh = %g k = %g\nfieldType = %s\nfSize = %g\nstopType=%s';
                fprintf(file,text,o.eOpt.gamma,char(o.eOpt.alpha),char(o.eOpt.beta),o.iOpt.epsilon,o.iOpt.deltaT,o.cOpt.numPts,o.cOpt.x,o.cOpt.y,o.cOpt.h,o.cOpt.k,o.iOpt.filter.fieldType,o.iOpt.fSize,o.iOpt.filter.stopType);
                fclose(file);
            end
            saveas(imgPlot,fNameFig);
        end
    end
    
    z = result;
    %finalVecInt = result.integral
end