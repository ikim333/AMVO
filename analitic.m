function [analitic_conv_u, analitic_conv_v, analitic_diff_u, analitic_diff_v] = analitic (N, coord_u, coord_v, visc, delta)

syms x y

vars = [x y];

u = [sin(2*pi*x)*cos(2*pi*y), cos(2*pi*x)*sin(2*pi*y)];

field_conv = u(1)*u;
field_diff = gradient(u(1));

analitic_conv = divergence(field_conv, vars);
analitic_diff = divergence(field_diff, vars);

x = coord_u(:,:,1);
y = coord_u(:,:,2);

analitic_conv_u = eval(analitic_conv);
analitic_conv_u = halo_updt(analitic_conv_u);
analitic_conv_u = analitic_conv_u(2:N+1,2:N+1);
analitic_diff_u = visc*eval(analitic_diff);
analitic_diff_u = halo_updt(analitic_diff_u);
analitic_diff_u = analitic_diff_u(2:N+1,2:N+1.);

x = coord_v(:,:,1);
y = coord_v(:,:,2);

analitic_conv_v = eval(analitic_conv);
analitic_conv_v = analitic_conv_v(2:N+1,2:N+1);
analitic_diff_v = visc*eval(analitic_diff);
analitic_diff_v = visc*analitic_diff_v(2:N+1,2:N+1);









