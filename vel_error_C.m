
%This function calcualtes the error as the difference between the analitc
%and numeric values of the velocity field. Given an error as input, if the
%new caluclated error is higher it is taken as the new error value. Else,
%the old error value is returned.

function error = vel_error_C(u_an, v_an, u_num, v_num, error_old)

error = error_old;

error_u = abs(u_an-u_num);
error_v = abs(v_an-v_num);

error_new = max (max (max(error_u)),max( max(error_v)));

if error_new>error_old
    error = error_new;
end

end