function print_field (u, nom)

n=size(u,1)-2;

fprintf('%s \n',nom);

for j=n+2:-1:1    
    for i=1:n+2
        fprintf('%4.4f    ', u(i,j));          
    end
        fprintf('\n')
end
    
end