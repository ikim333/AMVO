%AUTHORS: Miquel Badia, Daniel Longaron, Aranu Reyes
%TEAM 06

%% ARBITRARY VELOCITIES
%this function fixes arbitrary velocities for part B

function [u,v] = arbitrary_velocities_B (N)

%the following arbitrary velocities are fixed. The local mass conservation
%will not be satisfied, however, the global will be satisfied.
u = zeros (N+2, N+2);
v = zeros (N+2, N+2);

u(N+1, 2) = 1.2;

u = halo_updt (u);
v = halo_updt (v);


end