%AUTHORS: Miquel Badia, Daniel Longarón, Aranu Reyes
%TEAM 06

%%This f
function print_field (u, nom)

n = size(u,1)-2;

fprintf('%s \n',nom);

for j=n+2:-1:1    
    for i=1:n+2
        if u(i,j)<0
        fprintf('%4.2f    ', u(i,j));    
        else 
        fprintf('% 4.2f    ', u(i,j)); 
        end
    end
        fprintf('\n')
end

 fprintf('\n')
 fprintf('\n')
    
end