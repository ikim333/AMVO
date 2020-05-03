%% VELOCITY FIELD

% This function calculates the velocity field with zero divergence for a 
% given time using a periodic function as seen in slide 42 from 
% 2- Numerical Solution

function [u,v] = velocity_field(N, delta, visc,t)
    %We calculate the coordinates where the velocities shall be located
    [coord_u, coord_v] = coordinates (N, delta);
    
    u = zeros(N+2,N+2);
    v = zeros(N+2,N+2);
    
    % Now we calculate the velocity field inside the halo
    if (visc~=0)
        % If the viscosity difers from 0, the field will be periodic
        f = exp(-8*pi^2*visc*t);
    else
        % If the viscosity is equal to 0, the field will be constant
        f=1;
    end
    
    for i = 2:(N+1)
        for j = 2:(N+1)      
            u(i,j) = f*cos(2*pi*coord_u(i,j,1))*sin(2*pi*coord_u(i,j,2));
            v(i,j) = -f*sin(2*pi*coord_v(i,j,1))*cos(2*pi*coord_v(i,j,2));
        end
    end
    
    % Halo Update
    u = halo_updt(u);
    v = halo_updt(v);
end

