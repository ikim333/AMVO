%AUTHORS: Miquel Badia, Daniel Longarón, Aranu Reyes
%TEAM 06

%% TIME STEP
%this function will determine the delta_t that differences n-1 form n
%conditions

function delta_t = time_step (u, v, delta, visc)

f = 0.2; %f can be 0.2 -> 0.5

t_c = min(min(delta./sqrt(u.^2+v.^2))); %convective time limit

t_d = 0.5*(delta^2/visc); %difussive time limit

delta_t = f * min(t_c,t_d); %seconds

end