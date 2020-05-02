function [p, U, V, div_U] = pressure (Rx, Ry, delta_t, u, v, N, delta, density, A)

%R(n) i R(n-1) es poden calcular amb els mateixos camps de velocitats, per
%tant R(n) = R(n-1):

Rxn = Rx;
Ryn = Ry;

up = u + delta_t.*(1.5.*Rx-0.5.*Rx);
vp = v + delta_t.*(1.5.*Ry-0.5.*Ry);

up = halo_updt(up);
vp = halo_updt(vp);

for i=2:N+1
    for j=2:N+1
        uw(i-1,j-1) = up(i-1,j);
        vs(i-1,j-1) = vp(i,j-1);
    end
end

    %Agafem només els valors centrals
    up = up(2:N+1,2:N+1);
    vp = vp(2:N+1,2:N+1);


%crearem la matriu b per calcular pseudo_p
b = zeros(N^2,1);

for i=1:N^2
    b(i) = delta*(vp(i)-vs(i)+up(i)-uw(i));
end

div_U = sum(b);

pseudo_p = A\b;

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
p = halo_updt(p);
up = halo_updt(up);
vp = halo_updt(vp);

%es calculen els gradients de pressió en les dues direccions:
gradient_px = zeros(N+2,N+2);
gradient_py = zeros(N+2,N+2);

for i=2:N+1
        for j=2:N+1
            gradient_px(i,j) = (pseudo_p(i+1,j+1)-pseudo_p(i,j+1)) / delta;
            gradient_py(i,j) = (pseudo_p(i+1,j+1)-pseudo_p(i+1,j)) / delta;
        end
end
    
gradient_px = halo_updt(gradient_px);
gradient_py = halo_updt(gradient_py);
up = halo_updt(up);
vp = halo_updt(vp);

U = up - gradient_px;
V = vp - gradient_py;

U = halo_updt(U);
V = halo_updt(V);


end