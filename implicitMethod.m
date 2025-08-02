function sol = implicitMethod(u,f)
% inputs, 
%  u : Boundary conditions / image data
%  f : Function / image data column vector
%  
% outputs,
%  sol : Implicit method solution
%
% Reference: Numerical Analysis 7th Edition, Burden, p694-698
% Function was written Spring 2014 by Adam Bowden, GA at TAMU-C
    [n,m,~]=size(u);
         
    n = n-1;
    m = m-1;
    
    rowIndex=zeros(1,(n-1)*(m-1)); %Row index
    colIndex=zeros(1,(n-1)*(m-1)); %Column index
    coefficient=zeros(1,(n-1)*(m-1)); %Coefficient at the row and column index

    %Finite difference coefficients
    alpha = 1;
    beta = 4;
    
    %Initialize coefficients for matrix
    col=1;
    i=1;
    idx=1;
    for row=1:(n-1)*(m-1)
        %New row, reset i,j
        if(i==n)  
            i=1;
        end     
        if(row>n-1) %Not at bottom boundary, set coefficient
            rowIndex(idx)=row;
            colIndex(idx)=col-(n-1);
            coefficient(idx)=-alpha;
            idx=idx+1;
        end
        if(i>1) %Not at upper boundary, set coefficient
            rowIndex(idx)=row;
            colIndex(idx)=col-1;            
            coefficient(idx)=-alpha;
            idx=idx+1;
        end
        %Set current variable coefficient
        rowIndex(idx)=row;
        colIndex(idx)=col;        
        coefficient(idx)=beta;
        idx=idx+1;
        if(i<n-1) %Not at right boundary, set coefficient 
            rowIndex(idx)=row;
            colIndex(idx)=col+1;
            coefficient(idx)=-alpha;
            idx=idx+1;
        end
        if(row<=(n-1)*(m-1)-(n-1)) %Not at left boundary, set coefficient
            rowIndex(idx)=row;
            colIndex(idx)=col+(n-1);
            coefficient(idx)=-alpha;
            idx=idx+1;
        end
        i=i+1;
        col=col+1;
    end
    A=sparse(rowIndex,colIndex,coefficient,(n-1)*(m-1),(n-1)*(m-1)); %Create sparse coefficient matrix
    
    %Initialize column vector B with values from boundary conditions
    B = -f;
    B(1)=B(1)+u(1,m)+u(2,m+1);
    
    i=3;
    for var=2:n-1
        B(var)=B(var)+u(i,m+1);
        if(i==n)
            B(var)=B(var)+u(i+1,m);
        end
        i=i+1;
    end
    
    i=2;
    j=m-1;    
    for var=n:(n-1)*(m-1)-(n-1)
        if(i==2)
            B(var)=B(var)+u(i-1,j);
        end
        if(i==n)
            B(var)=B(var)+u(i+1,j);
            j=j-1;
            i=1;
        end
        i=i+1;
    end
    
    B((n-1)*(m-1)-(n-2))=B((n-1)*(m-1)-(n-2))+u(1,2)+u(2,1);
      
    i=3;
    for var=(n-1)*(m-1)-(n-3):(n-1)*(m-1)-1
        B(var)=B(var)+u(i,1);
        i=i+1;
    end
    
    if m == n
        B((n-1)*(m-1))=B((n-1)*(m-1))+u(n,1)+u(m+1,2);
    end
    
    %Solve Ax=B
    sol = A\B;
end