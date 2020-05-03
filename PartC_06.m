%%PART C

%AUTHORS: Miquel Badia, Daniel Longaron, Aranu Reyes
%TEAM 06

%Code description

%%
clear all
clc

%% DATA INPUT

%Geometrical, phisicall and numerical parameters

L = 1;    %Lenght of the domain (square domain, Lenght = Width)
visc = 1.2;   %Re = 100
density = 1; % density [kg/m^3]

N = 10;   % number mesh divisions
nts = 60; % number of time steps

delta = L/N;

% Now we can set up the necessary vectors to plot the results later
u_num = zeros(1,nts);
v_num = zeros(1,nts);
K_num = zeros(1,nts);
P_num = zeros(1,nts);
u_an = zeros(1,nts);
v_an = zeros(1,nts);
K_an = zeros(1,nts);
P_an = zeros(1,nts);
t = zeros(1,nts);

%% ANALITIC SOLUTION
% Now we calculate the analytical solution for the velocities and pressure
% fields when t = 0s

[u_an0,v_an0,P_an0] = analytic_solution_C (N, delta, t, visc, density);

k = kinetic_energy(u_an0, v_an0, delta, N);

%We call the velocity numerical field function calculator
[u,v] = arbitrary_velocities_C(N, delta, visc,t(1));

[p, u1, v1, div_u] = pressure_field (u, v, N, delta, visc, density);

K = kinetic_energy(u1, v1, delta, N);

u_num(1)=u1(3,3);
v_num(1)=v1(3,3);
P_num(1)=p(3,3);
K_num(1)=K;
u_an(1)=u_an0(3,3);
v_an(1)=v_an0(3,3);
P_an(1)=P_an0(3,3);
K_an(1)=K;

% Process iteration for each time step
for i=2:nts
    
    delta_t = time_step(u, v, delta, visc); %[s]
    t(i) = t(i-1) + delta_t; %[s]
    
    [u, v] = arbitrary_velocities_C (N, delta, visc, t(i));
    
    [p, u1, v1, div_u] = pressure_field (u, v, N, delta, visc, density);

    K = kinetic_energy(u1, v1, delta, N);
    
    [u_an0, v_an0, P_an0] = analytic_solution_C (N, delta, t(i), visc, density);
    k = kinetic_energy(u_an0,v_an0,delta,N);
    
    %Finally we fill the desired vectors for post-processing
    u_num(i)=u1(3,3);
    v_num(i)=v1(3,3);
    P_num(i)=p(3,3);
    K_num(i)=K;
    u_an(i)=u_an0(3,3);
    v_an(i)=v_an0(3,3);
    P_an(i)=P_an0(3,3);
    K_an(i)=K;
    
end

%% POSTPROCESSING

%Plot 

figure
hold on
grid on
plot(t,u_an,'b','LineWidth',2);
plot(t,u_num,'--r','LineWidth',1);
plot(t,v_an,'k','LineWidth',2);
plot(t,v_num,'--g','LineWidth',1);
ylabel('Velocity at position (3,3) [m/s]')
xlabel('Time [s]')
legend('u_a','u_n_u_m','v_a','v_n_u_m')

figure
hold on
grid on
plot(t,K_an,'LineWidth',2);
plot(t,K_num,'--','LineWidth',1);
ylabel('Kinetic energy [J]')
xlabel('Time [s]')
legend('K_a','K_n_u_m')
