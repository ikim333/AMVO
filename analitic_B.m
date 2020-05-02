function analitic_p = analitic_B (density, coord_u, coord_v, visc, delta_t)

syms x y

u =  cos(2*pi*x) * sin(2*pi*y);
v = -cos(2*pi*y) * sin(2*pi*x);

F = exp(-8*pi^2*visc*delta_t);

p = -density * F * 0.5*(cos(2*pi*x)^2 + cos(2*pi*y)^2);

x = coord_u(:,:,1);
y = coord_u(:,:,2);

analitic_p = eval(p);

end