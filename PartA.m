%%PART A

%AUTHORS: Miquel Badia, Daniel Longarón, Aranu Reyes
%TEAM ?¿?

%This program computes the diffusive and convective term of the NS
%equations  in a periodic two-dimensional domain, using a finite-control volume method
%The numerical solution obtained is comapred to an analytical solution to
%validate the results.

clear all
clc

%% DATA INPUT

%Geometrical, phisicall and numerical parameters

L=1;    %Lenght of the domain (square domain, Lenght = Width)

visc=1.2;   %Viscosity of the fluid []

%The simulation is carried out for different mesh densities

n_eval=7;   %Number of different mesh densities studied

%Initialize vector with the number of divisions in each axis (one value for each mesh density being studied) 
N = zeros(n_eval,1);    

%Assign values multiple of 10 to the number of divisions N
for i=1:n_eval
  
    N(i)=i*10;  
    
end


error = zeros(2,n_eval);    %Initialize error vector

%% PREPROCESSING and PROCESSING

%Calcualtions to be carried out for each meash density
for i=1:n_eval
    
    %% PREPROCESSING
    
    % Size of each division of the domain
    delta(i)=(L/N(i));  

    %Coordinates of each node of the domain
    [coord_u, coord_v] = coordinates (N(i), delta(i));

    %Velocity at each node of the domain
    [u,v] = arbitrary_velocities (N(i), coord_u, coord_v);


    %% PROCESSING

    %Numerical diffusive term
    [diffusive_term_u, diffusive_term_v] = diffusive(u, v, N(i), delta(i), visc);

    %Numerical convective term
    [convective_term_u] = convective(u, v, delta(i), N(i));
    [convective_term_v] = convective(v, u, delta(i), N(i));

    %Analitycal convective and diffusive terms
    [analitic_conv_u, analitic_conv_v, analitic_diff_u, analitic_diff_v] = analitic (N(i), coord_u, coord_v, visc, delta(i));

    [error_conv, error_diff] = max_error (analitic_conv_u, convective_term_u, analitic_diff_u, diffusive_term_u, N(i));

    error(1,i) = error_conv;
    error(2,i) = error_diff;
    
    
    
end


%% POSTPROCESSING

loglog(delta,error(1,:))   %Evolució del terme convectiu
grid on
hold on
loglog(delta,error(2,:))    %Evolució del terme difusiu
loglog(delta,delta.^2)
legend('Convectiu x','Difusiu x','h^2')
axis([10^-2 10^-1 10^-5 10])
xlabel('log h')
ylabel('log Error')

