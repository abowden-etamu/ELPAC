function potentialField = poisson(img)
% inputs, 
%  img : Gray level image data
%  
% outputs,
%  potentialField : Poisson equation potential energy field
%
% Function was written Spring 2014 by Adam Bowden, GA at TAMU-C
    [n,m,~]=size(img);
    
    [dx,dy]=gradient(img);
    
    %Calculate |grad(I)|^2 normalized
    absGradI=zeros(n,m,'double');
    %absGradI=divergence(dx,dy);
    for i=1:n
        for j=1:m
            %absGradI(i,j)=dx(i,j)+dy(i,j);
            absGradI(i,j)=dx(i,j)^2+dy(i,j)^2;
        end
    end
    %absGradI(:,:)=absGradI(:,:)+img(:,:);
    absGradI = normalize(absGradI,0,255);
    
    n = n-1;
    m = m-1;               
    X=zeros((n-1)*(m-1),1);
    
    %Initialize column matrix with image gradient values
    for j=2:m
       X(1+((n-1)*(j-2)):(j-1)*(n-1),1)=-absGradI(2:n,j);
    end
    
    sol = implicitMethod(absGradI,X); %Implicit method matrix solution
          
    %Replace gradient values with implicit method solution
    for j=1:m-1
       absGradI(2:n,j+1)=sol(1+(n-1)*(j-1):j*(n-1),1);
    end
    
    
    %Normalized potential
    newVal = absGradI(2:n,2:m);
    newVal = normalize(newVal,0,255);       
    absGradI(2:n,2:m)=newVal;   
   
    potentialField = absGradI;
end