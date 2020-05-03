%AUTHORS: Miquel Badia, Daniel Longaron, Aranu Reyes
%TEAM 06

%% HALO UPDATE

%To avoid boundary conditions, a periodic domain is used. 
%Given the distribution of a certain variable along the domain, this
%function calculates the value of said variable at the edges of the domain.

function F = halo_updt(F)
    n=size(F,1)-2;
        
    F(1,:)=F(n+1,:); % Last row -> to first row
    F(n+2,:)=F(2,:); % First row -> to last row
    F(:,1)=F(:,n+1); % Last column -> to first column
    F(:,n+2)=F(:,2); % First column -> to last column
end