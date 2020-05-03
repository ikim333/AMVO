%% PRESSURE MATRIX

%This function creates the singular Pressure Matrix in order to solve the pressure.
%As it is a singular matrix, the system would be unsolvable, so we may
%perturbe the matrix imposing the first value P_mat(1,1) = -5, instead of
%the -4.

function P_mat = pressure_matrix(N)
    P_mat=zeros(N^2,N^2);
    M=zeros(N);
    M_cords=zeros(N^2,2);
    
    % First we build a matrix (M) that saves the cell numbers, 
    % which will be used to fill the pressure matrix
    a=1;
    for i=N:-1:1
        for j=1:N
            M(i,j)=a;
            M_cords(a,:)=[i,j];
            a=a+1;
        end
    end

    % We can now fill the pressure matrix using the coordinates vector and the values saved
    % inside the matrix M. This way we can fill each row from the pressure
    % matrix.
    for i=1:(N^2)
        % X Axis Swipe
        if (M_cords(i,2)+1 <= N)
            P_mat(i,M(M_cords(i,1),M_cords(i,2)+1))=1;
        else
            P_mat(i,M(M_cords(i,1),1))=1;
        end
        
        if (M_cords(i,2)-1 > 0)
            P_mat(i,M(M_cords(i,1),M_cords(i,2)-1))=1;
        else
            P_mat(i,M(M_cords(i,1),N))=1;
        end
        
        % Y Axis Swipe
        if (M_cords(i,1)+1 <= N)
            P_mat(i,M(M_cords(i,1)+1,M_cords(i,2)))=1;
        else
            P_mat(i,M(1,M_cords(i,2)))=1;
        end
        
        if (M_cords(i,1)-1 > 0)
            P_mat(i,M(M_cords(i,1)-1,M_cords(i,2)))=1;
        else
            P_mat(i,M(N,M_cords(i,2)))=1;
        end
        
        % Diagonal
        if i==1
            P_mat(i,i)=-5;
        else
            P_mat(i,i)=-4;
        end
    end
end