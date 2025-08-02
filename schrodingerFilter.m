function filteredI = schrodingerFilter(img,p,k)
% inputs, 
%  img : Gray level image data
%  p,k : Integers which decide the size of the filter kernel
%  
% outputs,
%  filteredI : Filtered gray level image
%
% Reference:    Todorov, M. D., Sirakov, N. M., & Suh, S. (2013). 
%               Fast splitting scheme to minimize new energy functional containing Schröding erequation solution. 
%               AIP Conference Proceedings
%               
%               Bowden, Adam
%               Implementation of a Finite Splitting Scheme to Segment
%               Images with the Solution to the Poisson and Schrodinger
%               Equations
% Function was written Spring 2014 by Adam Bowden, GA at TAMU-C
    [rows,cols,~] = size(img);
    n=2*p+1;
    m=2*k+1;
        
    if(p == 0 && k == 0)
        filteredI = img;
        return;
    end
    
    %Pad image
    paddedImg = zeros(rows+2*p,cols+2*k,'double');
    paddedImg(:) = 255;
    
    imgFiltered = zeros(rows,cols,'double');
    filter = zeros(n,m,'double');
    
    paddedImg(p+1:rows+p,k+1:cols+k)=img(1:rows,1:cols);
    paddedImg(1:p,k:cols+k-1) = img(1:p,1:cols);
    paddedImg(rows+p:rows+2*p,k:cols+k-1) = img(rows-p:rows,1:cols);
    
    paddedImg(p:rows+p-1,1:k) = img(1:rows,1:k);
    paddedImg(p:rows+p-1,cols+k:cols+2*k) = img(1:rows,cols-k:cols);
    
    i=-p:1:p;
    j=-k:1:k;    
    
    N=n*m;
    %Convolve filter - slow and could be made faster using freq domain?
    for r=p+1:rows+p
        for c=k+1:cols+k
            mean = sum(sum(paddedImg(r-p:r+p,c-k:c+k)))/N;
            sigma = sqrt((sum(sum(mean - paddedImg(r-p:r+p,c-k:c+k)))^2))/N;
            for ii=1:n
                for jj=1:m
                    filter(ii,jj)=cosh(sigma*sqrt((i(ii))^2+(j(jj))^2));
                end
            end
            imgFiltered(r-p,c-k)=sum(sum(paddedImg(r-p:r+p,c-k:c+k)*filter(1:n,1:m)));
        end
    end
    
    filteredI = imgFiltered;
end