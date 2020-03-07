%% HALO UPDATE

function F = halo_updt(F)
    n=size(F,1)-2;
        
    F(1,:)=F(n+1,:); % Last row -> to first row
    F(n+2,:)=F(2,:); % First row -> to last row
    F(:,1)=F(:,n+1); % Last column -> to first column
    F(:,n+2)=F(:,2); % First column -> to last column
end