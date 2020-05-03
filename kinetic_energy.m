%AUTHORS: Miquel Badia, Daniel Longaron, Aranu Reyes
%TEAM 06

%% KINETIC ENERGY
%This function returns the kinetic energy value for each given velocity 
%field component 

function k = kinetic_energy(u, v, delta, N)
    
    dV = delta^2;
    k = 0;
    
    for i=2:(N+1)
        for j=2:(N+1)
            U = [0.5*(u(i,j)+u(i-1,j)),0.5*(v(i,j)+v(i-1,j))];           
            k = k+0.5*dot(U,U)*dV; 
        end
    end 
end
