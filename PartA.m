%%APARTAT A
clear all
clc

%dades
L=1;
visc=1.2;
n_eval=7;
nom='APARTAT A';

%es crea "array" amb les diferentes subdivisions a evaluar
N_eval = zeros(n_eval,1);
error = zeros(2,n_eval);

for i=1:n_eval
   
    N_eval(i)=i*10;
    
end

for i=1:n_eval
    
    N=N_eval(i);

    delta(i)=(L/N);

    [coord_u, coord_v] = coordinates (N, delta(i));

    [u,v] = arbitrary_velocities (N, coord_u, coord_v);


%%

%%TERME DIFUSIU + CONVECTIU + ANALITIC + ERROR

    [diffusive_term_u, diffusive_term_v] = diffusive(u, v, N, delta(i), visc);

    [convective_term_u] = convective(u, v, delta(i), N);
    [convective_term_v] = convective(v, u, delta(i), N);

    [analitic_conv_u, analitic_conv_v, analitic_diff_u, analitic_diff_v] = analitic (N, coord_u, coord_v, visc, delta(i));

    [error_conv, error_diff] = max_error (analitic_conv_u, convective_term_u, analitic_diff_u, diffusive_term_u, N);

    error(1,i) = error_conv;
    error(2,i) = error_diff;
    
    
    
end


loglog(delta,error(1,:))   %Evolució del terme convectiu
grid on
hold on
loglog(delta,error(2,:))    %Evolució del terme difusiu
loglog(delta,delta.^2)
legend('Convectiu x','Difusiu x','h^2')
axis([10^-2 10^-1 10^-5 10])
xlabel('log h')
ylabel('log Error')

