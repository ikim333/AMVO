%% LOCAL MASS CONSERVATION
%this function will verify that for all nodes assessed, the mass is
%conserved, which is equivalent to: the velocity that enters is equal tot
%the velocity that comes out

function mass = local_mass_conservation (N, u, v)

mass = zeros(N,N);

for i=2:N+1
    for j=2:N+1
        
        mass(i-1,j-1) = - u(i,j) - v(i,j) + u(i-1,j) + v(i,j-1); 
        
    end
end

%approximation for each value
mass = round (mass, 4);

end