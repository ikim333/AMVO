%AUTHORS: Miquel Badia, Daniel Longaron, Aranu Reyes
%TEAM 06

%% COORDINATES
%This function returns the 2D coordinates of each node of the domain, given
%the number of divisions and the size of each division of said domain

function [coord_u, coord_v] = coordinates (N, delta)

%Initialize coordinate vectors
coord_u=zeros(N,N,2);
coord_v=zeros(N,N,2);

for i=1:N+2
    for j=1:N+2
        
        coord_u(i,j,:)=[(i-1)*delta, ((j-1)-1/2)*delta]; %Horizontal coordinates at each node
        coord_v(i,j,:)=[((i-1)-1/2)*delta, (j-1)*delta]; %Vertical coordinates at each node
        
    end
end
end
