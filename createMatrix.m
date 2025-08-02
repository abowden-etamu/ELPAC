function mat = createMatrix(n,h,deltaT,alpha,gamma,beta)
% inputs, 
%  n : Number of contour points
%  h : Space step
%  deltaT : Time step
%  alpha, beta, gamma: Energy coefficents
%    
% outputs,
%  mat : Sparse coeffiecent matrix for numerical splitting scheme
%
% Reference:    Todorov, M. D., Sirakov, N. M., & Suh, S. (2013). 
%               Fast splitting scheme to minimize new energy functional containing Schrödinger equation solution. 
%               AIP Conference Proceedings
%               
%               Bowden, Adam
%               Implementation of a Finite Splitting Scheme to Segment
%               Images with the Solution to the Poisson and Schrodinger
%               Equations
% Function was written Spring 2014 by Adam Bowden, GA at TAMU-C
    coef = (deltaT/(gamma*h^4));
    [a,b,c,d,e] = deal(zeros(n,1,'double'));

    %Set up coefficients
    parfor i=1:n
        a(i) = coef*beta(i-1);
        b(i) = -coef*( (h^2)*alpha(i)+2*beta(i-1)+2*beta(i) );
        c(i) = 1+coef*( (h^2)*alpha(i+1)+(h^2)*alpha(i)+beta(i-1)+4*beta(i)+beta(i+1) );
        d(i) = -coef*( (h^2)*alpha(i+1)+2*beta(i)+2*beta(i+1) );
        e(i) = coef*beta(i+1);
    end
    
    %First two row must be initialized separetely due to wrap around
    A(1,1:5)=[c(1),0,d(1),0,e(1)];
    A(1,2*n-3:2*n-1)=[a(n),0,b(n)];
    A(2,2:6)=[c(1),0,d(1),0,e(1)];        
    A(2,2*n-2:2*n)=[a(n),0,b(n)];
    
    A(3,1:7)=[b(2),0,c(2),0,d(2),0,e(2)];
    A(3,2*n-1)=a(n);
    A(4,2:8)=[b(2),0,c(2),0,d(2),0,e(2)];    
    A(4,2*n)=a(n);
    
    j=3;
    for i=5:2:2*n-5
        A(i,(i-4):(i+4))=[a(j),0,b(j),0,c(j),0,d(j),0,e(j)];
        A(i+1,(i-3):(i+5))=[a(j),0,b(j),0,c(j),0,d(j),0,e(j)];
        j=j+1;
    end
    
    %Last two row must be initialized separetely due to wrap around
    A(2*n-3,2*n-7:2*n)=[a(n-1),0,b(n-1),0,c(n-1),0,d(n-1),0];
    A(2*n-3,1)=e(1);
    A(2*n-2,2*n-6:2*n)=[a(n-1),0,b(n-1),0,c(n-1),0,d(n-1)];
    A(2*n-2,1:2)=[0,e(1)];

    A(2*n-1,2*n-5:2*n)=[a(n),0,b(n),0,c(n),0];
    A(2*n-1,1:3)=[d(1),0,e(1)];
    A(2*n,2*n-4:2*n)=[a(n),0,b(n),0,c(n)];
    A(2*n,2:4)=[d(1),0,e(1)];
    
    mat = sparse(A); %Sparse matrix - saves time when solving
end