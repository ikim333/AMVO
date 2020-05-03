%AUTHORS: Miquel Badia, Daniel Longaron, Aranu Reyes
%TEAM 06

%% PRESSURE
%this function calculates the pressure and velocities at t=n, which will be
%then be used to verify the mass conservation

function [p, u1, v1] = pressure_velocity (pseudo_p, density, delta_t, delta, N, up, vp)

pseudo_p = reshape(pseudo_p,[N,N]);

%calculation of pressure in each node
p = pseudo_p * density / delta_t;

%enlarge matrix p and pseudo_p to N+2
pseudo_p_ampl = zeros(N+2,N+2);
p_ampl = zeros(N+2,N+2);
up_ampl = zeros(N+2,N+2);
vp_ampl = zeros(N+2,N+2);

for i=1:N
    for j=1:N
        pseudo_p_ampl(i+1,j+1) = pseudo_p(i,j);
        p_ampl(i+1,j+1) = p(i,j);
        up_ampl(i+1,j+1) = up(i,j);
        vp_ampl(i+1,j+1) = vp(i,j);
    end
end

pseudo_p = pseudo_p_ampl;
p = p_ampl;
up = up_ampl;
vp = vp_ampl;

pseudo_p = halo_updt(pseudo_p);

%pressure gradient is calculated for both directions
gradient_px = zeros(N+2,N+2);
gradient_py = zeros(N+2,N+2);

for i=2:N+1
        for j=2:N+1
            gradient_px(i,j) = (pseudo_p(i+1,j)-pseudo_p(i,j)) / delta;
            gradient_py(i,j) = (pseudo_p(i,j+1)-pseudo_p(i,j)) / delta;
        end
end

%velocities at t=n
u1 = up - gradient_px;
v1 = vp - gradient_py;

%halo update
u1 = halo_updt(u1);
v1 = halo_updt(v1);


end