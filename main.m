%%APARTAT A
clear all
clc

%%
%Commit prova 2

%%

L=1;
N=3;
nom='APARTAT A';

delta=(L/N);

[coord_u, coord_v] = coordinates (N, delta);

u=zeros(N+2, N+2);
v=zeros(N+2, N+2);

[u,v] = arbitrary_velocities (u, v, N, delta);

%print_field(u,'no halo')
%print_field(v,'no halo')
%print_field(halo_updt(u),'halo')
%print_field(halo_updt(v),'halo')

%%

%%TERME DIFUSIU + CONVECTIU

[diffusive_term_u, diffusive_term_v] = diffusive(u, v, N, delta);

[convective_term_u] = convective(u, v, delta, N);
[convective_term_v] = convective(v, u, delta, N);




%%


%u = halo_updt(u)

%u(3,1)=31;

%u=halo_updt(u);

%print_field(u,nom)

