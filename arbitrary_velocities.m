function [u,v] = arbitrary_velocities (u, v, N, delta)

for i=2:N+1
    for j=2:N+1
        
        [u(i,j)]=sin(i*delta)*cos(j*delta);
        [v(i,j)]=cos(i*delta)*sin(j*delta);
        
    end
end
print_field(halo_updt(u),'halo u')
print_field(halo_updt(v),'halo v')
end