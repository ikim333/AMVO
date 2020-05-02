%%APARTAT B
clear all
clc

%dades
L=1;
visc=1.2;
n_eval=7;
density = 1;
nom='APARTAT B';

%%

N = 10;
delta = L/N;

%%

A = matrixA(N);

[coord_u, coord_v] = coordinates (N, delta);

[u,v] = arbitrary_velocities_B (N, coord_u, coord_v);

[diffusive_term_u, diffusive_term_v] = diffusive(u, v, N, delta, visc);

[convective_term_u] = convective(u, v, delta, N);
[convective_term_v] = convective(v, u, delta, N);

[Rx] = R_term (convective_term_u, diffusive_term_u, delta);
[Ry] = R_term (convective_term_v, diffusive_term_v, delta);

delta_t = time_step (u, v, delta, visc);

[p, U, V, div_U] = pressure (Rx, Ry, delta_t, u, v, N, delta, density, A)

%%

analitic_p = analitic_B (density, coord_u, coord_v, visc, delta_t);

error_p = abs(analitic_p - p);
error_p = max(max(error_p));


