%%PART C

%AUTHORS: Miquel Badia, Daniel Longarón, Aranu Reyes
%TEAM 6

%Code description

%%
clear all
clc

%% DATA INPUT

%Geometrical, phisicall and numerical parameters

L=1;    %Lenght of the domain (square domain, Lenght = Width)
visc=1.2;   %Viscosity of the fluid []
dens = 1; % density [kg/m^3]

N = 10;   % number mesh divisions
nts = 60; % number of time steps
delta = L/N;

dN = L/N;
dV = dN^2;

% Pressure matrix definition

P_mat = pressure_matrix(N);

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

% Now we calculate the analytical solution for the velocities and pressure
% fields when t = 0s

[u_ar,v_ar,P_ar] = analytic_solution_C(N,delta,t,visc,dens);

k = kinetic_energy(u_ar,v_ar,delta,N);

%We call the velocity numerical field function calculator
[u,v] = velocity_field(N, delta, visc,t(1));

% Now we calculate convective and diffusive terms
%Numerical diffusive term
[diffusive_term_u, diffusive_term_v] = diffusive(u, v, N, delta, visc);
    
%Numerical convective term
[convective_term_u] = convective(u, v, delta, N);
[convective_term_v] = convective(v, u, delta, N);

R_x = R_term_calc(convective_term_u,diffusive_term_u,dV);
R_y = R_term_calc(convective_term_v,diffusive_term_v,dV);

%Now we calculate the pressure field numerically for t=0s

delta_t=time_step(u,v,delta,visc);
[P,U,V,RX,RY,div_U] = pressure_field(u, v, diffusive_term_u, diffusive_term_v, convective_term_u, convective_term_v, delta, dens, N,R_x,R_y,delta_t,P_mat);
K = kinetic_energy(U,V,delta,N);

u_num(1)=U(3,3);
v_num(1)=V(3,3);
P_num(1)=P(3,3);
K_num(1)=K;
u_an(1)=u_ar(3,3);
v_an(1)=v_ar(3,3);
P_an(1)=P_ar(3,3);
K_an(1)=K;

% Process iteration for each time step
for i=2:nts
    
    delta_t=time_step(u,v,delta,visc); %[s]
    t(i)=t(i-1)+delta_t; %[s]
    
    [u,v] = velocity_field(N, delta, visc,t(i));
    
    %Numerical diffusive term
    [diffusive_term_u, diffusive_term_v] = diffusive(u, v, N, delta, visc);

    %Numerical convective term
    [convective_term_u] = convective(u, v, delta, N);
    [convective_term_v] = convective(v, u, delta, N);
    
    
    [P,U,V,RX,RY,div_U] = pressure_field(u, v, diffusive_term_u, diffusive_term_v, convective_term_u, convective_term_v, delta, dens, N,R_x,R_y,delta_t,P_mat);

    K = kinetic_energy(U,V,delta,N);
    
    R_x=RX;
    R_y=RY;
    
    [u_ar,v_ar,P_ar]=analytic_solution_C(N,delta,t(i),visc,dens);
    k = kinetic_energy(u_ar,v_ar,delta,N);
    
    %Finally we fill the desired vectors for post-processing
    u_num(i)=U(3,3);
    v_num(i)=V(3,3);
    P_num(i)=P(3,3);
    K_num(i)=K;
    u_an(i)=u_ar(3,3);
    v_an(i)=v_ar(3,3);
    P_an(i)=P_ar(3,3);
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
