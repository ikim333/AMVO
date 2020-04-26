function [A] = matrixA (N)

A = zeros(N^2,N^2);
B = zeros(N,N);
k = 1;

for i=N:-1:1
    for j=1:N
        B(i,j) = k;
        k = k+1;
    end
end

for i=1:N^2
    for j=1:N^2
       if i==j
         A(i,j) = -4;
       end
    end
end

j=1;
k=1;
for i=1:N^2
    
    if j==1 && k==1
    A(i,B(N+1-j,k+1)) = 1; %east
    A(i,B(N-j,k)) = 1; %north 
    A(i,B(1,k)) = 1; %south
    A(i,B(N+1-j,N)) = 1; %west
    k=k+1;
    
    else if j==1 && k<N && k~=1
    A(i,B(N+1-j,k+1)) = 1; %east
    A(i,B(N-j,k)) = 1; %north 
    A(i,B(1,k)) = 1; %south
    A(i,B(N+1-j,k-1)) = 1; %west
    k=k+1;
    
    else if k==N && j==1
    A(i,B(N+1-j,1)) = 1; %east
    A(i,B(N-j,k)) = 1; %north 
    A(i,B(1,k)) = 1; %south
    A(i,B(N+1-j,k-1)) = 1; %west
    k=1;
    j=j+1;
    
    else if k==1 && j<N && j~=1
    A(i,B(N+1-j,k+1)) = 1; %east
    A(i,B(N-j,k)) = 1; %north 
    A(i,B(N+2-j,k)) = 1; %south
    A(i,B(N+1-j,N)) = 1; %west
    k=k+1;
    
    else if k<N && j<N && j~=1
    A(i,B(N+1-j,k+1)) = 1; %east
    A(i,B(N-j,k)) = 1; %north 
    A(i,B(N+2-j,k)) = 1; %south
    A(i,B(N+1-j,k-1)) = 1; %west
    k=k+1;
    
    else if k==N && j<N && j~=1
    A(i,B(N+1-j,1)) = 1; %east
    A(i,B(N-j,k)) = 1; %north 
    A(i,B(N+2-j,k)) = 1; %south
    A(i,B(N+1-j,k-1)) = 1; %west
    k=1;
    j=j+1;
    
    else if j==N && k==1
    A(i,B(N+1-j,k+1)) = 1; %east
    A(i,B(N,k)) = 1; %north 
    A(i,B(N+2-j,k)) = 1; %south
    A(i,B(N+1-j,N)) = 1; %west
    k=k+1;
    
    else if j==N && k<N && k~=1
    A(i,B(N+1-j,k+1)) = 1; %east
    A(i,B(N,k)) = 1; %north 
    A(i,B(N+2-j,k)) = 1; %south
    A(i,B(N+1-j,k-1)) = 1; %west
    k=k+1;
    
    else if j==N && k==N
    A(i,B(N+1-j,1)) = 1; %east
    A(i,B(N,k)) = 1; %north 
    A(i,B(N+2-j,k)) = 1; %south
    A(i,B(N+1-j,k-1)) = 1; %west
    
    
    end           
    end            
    end
    end
    end
    end
    end
    end
    end
end

A(1,1)=-5;
A(N^2,N^2)=-5;
    
end %end function
    

