%% CONVECTIVE
%This function returns the values of the convective term of the NS equation
%for all nodes of the domain. It takes as inputs the velocity components at all nodes, the
% size of each division and number of divisions of the domain.

function [convective_term_u] = convective(u, v, delta, N)

%Initialize vector with convective term values.
convective_term_u = zeros (N+2, N+2);

for i=2:(N+1)
    for j=2:(N+1)
        
        %Calculate velocity at the walls of the node
        ue = (u(i+1,j) + u(i,j))/2;
        uw = (u(i-1,j) + u(i,j))/2;
        un = (u(i,j+1) + u(i,j))/2;
        us = (u(i,j-1) + u(i,j))/2;
       
        %Calculate flow at the walls
        Fs = (v(i,j-1)*delta + v(i+1,j-1)*delta)/2;
        Fn = (v(i,j)*delta + v(i+1,j)*delta)/2;
        Fe = (u(i+1,j)*delta + u(i,j)*delta)/2;
        Fw = (u(i-1,j)*delta + u(i,j)*delta)/2;
        
        %Calcualte the convective term
        convective_term_u(i,j) = ue*Fe - uw*Fw + un*Fn - us*Fs;
 
    end
end



%As a periodic domain is being used, obtain the value of the diffusive
%term at the edges using the halo_updt function
convective_term_u = halo_updt(convective_term_u);

convective_term_u = convective_term_u./delta^2;

%print_field(halo_updt(convective_term_u),'halo convective u')
%print_field(halo_updt(convective_term_v),'halo convective v')

end