%AUTHORS: Miquel Badia, Daniel Longaron, Aranu Reyes
%TEAM 06

%% DERIVATIVE
%This function returns the value of the partial derivatives of a component
%of the velocity in all directions. Thi inputs used are the value of the
%velocity in all nodes of the domain, the node being studied (i,j) and the
%size of a division of the domain.


function [du_xe, du_xw, du_yn, du_ys] = derivative (u, i, j, delta)
       
        du_xe=(u(i+1,j)-u(i,j))/delta;
        du_xw=(u(i,j)-u(i-1,j))/delta;
        du_yn=(u(i,j+1)-u(i,j))/delta;
        du_ys=(u(i,j)-u(i,j-1))/delta;
        
end
