function [convective_term_u] = convective(u, v, delta, N)

convective_term_u = zeros (N+2, N+2);

for i=2:(N+1)
    for j=2:(N+1)
        
        ue = (u(i+1,j) + u(i,j))/2;
        uw = (u(i-1,j) + u(i,j))/2;
        un = (u(i,j+1) + u(i,j))/2;
        us = (u(i,j-1) + u(i,j))/2;
        
        ve = (v(i+1,j) + v(i,j))/2;
        vw = (v(i-1,j) + v(i,j))/2;
        vn = (v(i,j+1) + v(i,j))/2;
        vs = (v(i,j-1) + v(i,j))/2;
        
        Fs = (v(i,j-1)*delta + v(i+1,j-1)*delta)/2;
        Fn = (v(i,j)*delta + v(i+1,j)*delta)/2;
        Fe = (u(i+1,j)*delta + u(i,j)*delta)/2;
        Fw = (u(i-1,j)*delta + u(i,j)*delta)/2;
        
        convective_term_u(i,j) = ue*Fe - uw*Fw + un*Fn - us*Fs;
        
        
    end
end

convective_term_u = halo_updt(convective_term_u);

convective_term_u = convective_term_u./delta^2;

%print_field(halo_updt(convective_term_u),'halo convective u')
%print_field(halo_updt(convective_term_v),'halo convective v')

end