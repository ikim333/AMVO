%% PRESSURE
%this function calculates the pressure and velocities at t=n, which will be
%then be used to verify the mass conservation

function [p, u1, v1] = pressure (pseudo_p, density, delta_t, delta, N, up, vp)

pseudo_p = reshape(pseudo_p,[N,N]);

p = pseudo_p * density / delta_t;

%ampliem les matrius p i pseudo_p a N+2
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

% pseudo_p = halo_updt(pseudo_p);
% p = halo_updt(p);
% up = halo_updt(up);
% vp = halo_updt(vp);

%pressure gradient is calculated for both directions
gradient_px = zeros(N+2,N+2);
gradient_py = zeros(N+2,N+2);

for i=2:N+1
        for j=2:N+1
            gradient_px(i,j) = (pseudo_p(i+1,j)-pseudo_p(i,j)) / delta;
            gradient_py(i,j) = (pseudo_p(i,j+1)-pseudo_p(i,j)) / delta;
        end
end
    
% gradient_px = halo_updt(gradient_px);
% gradient_py = halo_updt(gradient_py);
% up = halo_updt(up);
% vp = halo_updt(vp);

u1 = up - gradient_px;
v1 = vp - gradient_py;

u1 = halo_updt(u1);
v1 = halo_updt(v1);


end