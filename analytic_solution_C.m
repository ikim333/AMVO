%% PRESSURE MATRIX

% This function calculates the analytical solution for the velocities, and
% pressure fields in order to compare them with the numerical results.

function [u_an,v_an,P_an]=analytic_solution_C(N,delta,t,visc,dens)

    %We will calculate the velocities and pressure fields in both 
    %directions in a symbolic way.
    syms xx yx xy yy x_p y_p;

    %We shall use the example provided in slide 43 from 2- Numerical
    %Solution
    f = exp(-8*pi^2*visc*t);
    velocity=[f*cos(2*pi*xx)*sin(2*pi*yx),-f*cos(2*pi*yy)*sin(2*pi*xy)];
    pressure=(f.^2)*(dens*(cos(4*pi*x_p)+cos(4*pi*y_p)))/4;

    %We get the coordinates where the analytical calculation from the 
    %convective term will be located.
    [coord_u,coord_v] = coordinates(N, delta);
    xx=coord_u(:,:,1);
    yx=coord_u(:,:,2);
    xy=coord_v(:,:,1);
    yy=coord_v(:,:,2);
    
    [coord_P] = coordinates_P(N, delta);
    x_p=coord_P(:,:,1);
    y_p=coord_P(:,:,2);
    
    %Analytical calculation from the velocities and pressure.
    u_an=eval(velocity(1));    
    v_an=eval(velocity(2));    
    P_an=eval(pressure);
    
    % Halo update
    u_an = halo_updt(u_an);
    v_an = halo_updt(v_an);
    P_an = halo_updt(P_an);
    
   
end