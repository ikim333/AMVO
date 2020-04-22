function [u,v] = arbitrary_velocities (N, coord_u, coord_v)

%es creen velocitats arbitràries segon l'exemple donat a les transparències

u = zeros(N+2, N+2);
v = zeros(N+2, N+2);

for i=2:N+1
    for j=2:N+1
        
        [u(i,j)] = sin(2*pi*coord_u(i,j,1)) * cos(2*pi*coord_u(i,j,2));
        [v(i,j)] = cos(2*pi*coord_v(i,j,1)) * sin(2*pi*coord_v(i,j,2));
        
    end
end

u = halo_updt(u);
v = halo_updt(v);

%print_field(halo_updt(u),'halo u')
%print_field(halo_updt(v),'halo v')
end