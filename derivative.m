function [du_xe, du_xw, du_yn, du_ys] = derivative (u, i, j, delta)
       
        du_xe=(u(i+1,j)-u(i,j))/delta;
        du_xw=(u(i,j)-u(i-1,j))/delta;
        du_yn=(u(i,j+1)-u(i,j))/delta;
        du_ys=(u(i,j)-u(i,j-1))/delta;
        
end
