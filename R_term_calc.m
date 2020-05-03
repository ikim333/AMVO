%AUTHORS: Miquel Badia, Daniel Longarón, Aranu Reyes
%TEAM 06

%% R TERM 
%This function returns the calculation for the R term

function R = R_term_calc(convective,diffusive,delta)

    R = -convective./(delta^2)+diffusive./(delta^2);  %%s'ha canviat delta per dv oju

end