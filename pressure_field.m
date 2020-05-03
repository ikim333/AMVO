%% PRESSURE FIELD 
% This function calculates the pressure field for the given inputs

function [P,U,V,RX,RY,U_div] = pressure_field(u, v, diffusive_term_u, diffusive_term_v, convective_term_u, convective_term_v, delta, dens, N,R_x,R_y,ts,P_mat)
    
    dV=delta^2; 
    
    RX = R_term_calc(convective_term_u,diffusive_term_u,dV);
    RY = R_term_calc(convective_term_v,diffusive_term_v,dV);
    
    %Now we calculate the velocity predictor
    u_p = u + ts.*(3/2.*RX-1/2.*R_x); 
    v_p = v + ts.*(3/2.*RY-1/2.*R_y); 
    
    u_p = halo_updt(u_p);
    v_p = halo_updt(v_p);
    
    u_pw=zeros(N,N);
    v_ps=zeros(N,N);
    
    for i=2:(N+1)
        for j=2:(N+1)
            u_pw(i-1,j-1)=u_p(i-1,j);
            v_ps(i-1,j-1)=v_p(i,j-1);
        end
    end
    
    %We shall avoid the boundary values
    u_p=u_p(2:N+1,2:N+1);
    v_p=v_p(2:N+1,2:N+1);

    
    % Now we may calcculate the vector b as defined in page 34 from
    % 2- Numerical Solution. 
    
    b=zeros(N^2,1);
    for i=1:(N^2)
        b(i)=delta*(v_p(i)-v_ps(i)+u_p(i)-u_pw(i));
    end
    
    %In order to verify the results, we shall calculate the divergence from
    %U and expect it to be 0.
    U_div=sum(b);
    
    %Equations system resolution
    pseud_P=P_mat\b; 

    %We shall change the dimensions from the pseudo Pressure into a matrix
    %for the posterior calculations
    pseud_P=reshape(pseud_P,[N,N]);
    
    %Now we can calculate the pressure at n+1 isolating it from the 
    %expression seen in slide 30 from 2-Numerical-Solution.
    pressure=pseud_P*dens/ts; 
    
    %We include halo and update it
    P_ps=zeros(N+2);
    P=zeros(N+2);
    for i=1:N
        for j=1:N
            P_ps(i+1,j+1)=pseud_P(i,j);
            P (i+1,j+1) = pressure(i,j);
        end
    end
    P_ps=halo_updt(P_ps);
    P=halo_updt(P);   
    
    %Now we calculate the pressure gradients in both directions 
    Px_gradient=zeros(N);
    Py_gradient=zeros(N);
    for i=1:N
        for j=1:N
            Px_gradient(i,j)=(P_ps(i+1,j+1)-P_ps(i,j+1))/delta;
            Py_gradient(i,j)=(P_ps(i+1,j+1)-P_ps(i+1,j))/delta;
        end
    end
    
    %We include halo and update it
    px_grd=zeros(N+2);
    py_grd=zeros(N+2);
    up=zeros(N+2);
    vp=zeros(N+2);
    for i=1:N
        for j=1:N
            px_grd(i+1,j+1)=Px_gradient(i,j);
            py_grd(i+1,j+1)=Py_gradient(i,j);
            up(i+1,j+1)=u_p(i,j);
            vp(i+1,j+1)=v_p(i,j);
        end
    end
    px_grd=halo_updt(px_grd);
    py_grd=halo_updt(py_grd);
    up=halo_updt(up);
    vp=halo_updt(vp);
    
    %Finally we calculate velocity at n+1 

    U = up-px_grd;
    V = vp-py_grd;
    
    U = halo_updt(U); 
    V = halo_updt(V); 
    
end