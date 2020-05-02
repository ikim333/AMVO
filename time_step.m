function delta_t = time_step (u, v, delta, visc)

f = 0.2; 

t_c = min(min(delta./sqrt(u.^2+v.^2))); %temps limit convectiu

t_d = 0.5*(delta^2/visc); %temps limit difusiu

delta_t = f * min(t_c,t_d); %en segons

end