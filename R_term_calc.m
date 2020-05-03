%% R TERM 
%This function returns the calculation for the R term

function R = R_term_calc(convective,diffusive,dV)
    R = -convective./dV+diffusive./dV;  
end