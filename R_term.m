function [R] = R_term (convective_term, diffusive_term, delta)

R = -convective_term./delta^2 + diffusive_term./delta^2;

end