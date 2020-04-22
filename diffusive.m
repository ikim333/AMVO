function [diffusive_term_u, diffusive_term_v] = diffusive (u, v, N, delta, visc)

diffusive_term_u = zeros (N+2, N+2);
diffusive_term_v = zeros (N+2, N+2);

for i=2:(N+1)
    for j=2:(N+1)
        [du_xe, du_xw, du_yn, du_ys] = derivative (u, i, j, delta);
        [dv_xe, dv_xw, dv_yn, dv_ys] = derivative (v, i, j, delta);
        
        diffusive_term_u(i,j) = delta*du_xe - delta*du_xw + delta*du_yn - delta*du_ys;
        diffusive_term_v(i,j) = delta*dv_xe - delta*dv_xw + delta*dv_yn - delta*dv_ys;
    end
end

    diffusive_term_u = diffusive_term_u * visc;
    diffusive_term_v = diffusive_term_v * visc;
    
    diffusive_term_u = diffusive_term_u./delta^2;
    diffusive_term_v = diffusive_term_v./delta^2;
    
    diffusive_term_u = halo_updt(diffusive_term_u);
    diffusive_term_v = halo_updt(diffusive_term_v);

    %print_field(halo_updt(diffusive_term_u),'halo diffusive u')
    %print_field(halo_updt(diffusive_term_v),'halo diffusive v')
end
