%% Arbitrary velocity field
%This function returns the two components of the velocity at each node of
%the domain. This velocity field has been chosen arbitrarily, given that it
%fulfills a series of basic requierements. The input values used are the
%number of divisions of the domain and the ccordinates of each node.

function [u,v] = arbitrary_velocities (N, coord_u, coord_v)

%Initialize the velocity vectors
u = zeros(N+2, N+2);
v = zeros(N+2, N+2);

for i=2:N+1
    for j=2:N+1
        
        [u(i,j)] = sin(2*pi*coord_u(i,j,1)) * cos(2*pi*coord_u(i,j,2)); %Horizontal velocity component
        [v(i,j)] = cos(2*pi*coord_v(i,j,1)) * sin(2*pi*coord_v(i,j,2)); %Vertical velocity component
        
    end
end

%A perdiodic domain is used, velocities at the edges are obtained using the
%function halo_updt
u = halo_updt(u);
v = halo_updt(v);

%print_field(halo_updt(u),'halo u')
%print_field(halo_updt(v),'halo v')
end