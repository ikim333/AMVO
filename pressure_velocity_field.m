%AUTHORS: Miquel Badia, Daniel Longaron, Aranu Reyes
%TEAM 06

%% PRESSURE__VELOCITY_FIELD

function [p, u1, v1, div_u] = pressure_velocity_field (u, v, N, delta, visc, density)


%matrix A is calculated for N divisions
A = matrixA(N); 

% calculate convective and diffusive terms
%Numerical diffusive term
[diffusive_term_u, diffusive_term_v] = diffusive(u, v, N, delta, visc);
    
%Numerical convective term
[convective_term_u] = convective(u, v, delta, N);
[convective_term_v] = convective(v, u, delta, N);

Rx = R_term_calc(convective_term_u,diffusive_term_u,delta);
Ry = R_term_calc(convective_term_v,diffusive_term_v,delta);

% time-step calculated with the data given
delta_t = time_step (u, v, delta, visc);

%b vector is calculated
[b, div_u, up, vp] = b_vector (delta_t, delta, u, v, N, Rx, Ry, convective_term_u, diffusive_term_u, convective_term_v,diffusive_term_v);

%pseudo_p is calculated
pseudo_p = A \ b;

%calculation for the pressure in each CV
[p, u1, v1] = pressure_velocity (pseudo_p, density, delta_t, delta, N, up, vp);

end