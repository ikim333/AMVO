%AUTHORS: Miquel Badia, Daniel Longaron, Aranu Reyes
%TEAM 06

%% PRESSURE COORDINATES
%This function returns the 2D coordinates of each node of the domain for
%the pressure field, given the number of divisions and the size of each 
%division of said domain

function coord_P = coordinates_P(N,delta)

    coord_P = zeros(N+2,N+2,2);
    
    for i=1:(N+2)
        for j=1:(N+2)
            coord_P(i,j,:)=[((i-1)-1/2)*delta,((j-1)-1/2)*delta]; 
        end
    end
end