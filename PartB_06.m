%%PART B

%AUTHORS: Miquel Badia, Daniel Longarón, Aranu Reyes
%TEAM 06

%This program will compute the velocity in each CV and, thruoghout the
%pressure in each node, it will be verified that the local and global mass
%is constant
clear all
clc

%% DATA INPUT

%Geometrical, physical and numerical parameters
L=1;
visc=1.2;
n_eval=7;
density = 1; %the density of the fluid

%% NUMBER OF CV's

N = 10; %number of divisions
delta = L/N; %side of each CV, we consider squared CV's

%% PREPROCESSING & PROCESSING
%coordinates and arbitriary velocities in each CV for part B
[coord_u, coord_v] = coordinates (N, delta);

[u,v] = arbitrary_velocities_B (N, coord_u, coord_v);

%% PROCESSING
[p, u1, v1, div_u] = pressure_field (u, v, N, delta, visc, density);

%% RESULTS AND VERIFICATION

%verification divergence 
mass = local_mass_conservation (N, u, v);
mass1 = local_mass_conservation (N, u1, v1);

%numerical display of the results
print_field (mass, 'Mass conservation before')
print_field (mass1, 'Mass conservation after')
print_field (div_u, 'Velocity divergence')

%graphical display of the resultant vectors
display_B (L, delta, coord_u, coord_v, u, v, N);
display_B (L, delta, coord_u, coord_v, u1, v1, N);

