function [coord_u, coord_v] = coordinates (N, delta)

coord_u=zeros(N,N,2);
coord_v=zeros(N,N,2);

for i=1:N+2
    for j=1:N+2
        
        coord_u(i,j,:)=[(i-1)*delta, ((j-1)-1/2)*delta];
        coord_v(i,j,:)=[((i-1)-1/2)*delta, (j-1)*delta];
        
    end
end
end
