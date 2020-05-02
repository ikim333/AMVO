%% B VECTOR
%this function will calculate the b vector for the given velocities and
%data

function [b, div_u, up, vp] = b_vector (delta_t, delta, u, v, N)

%velocities for instant n-1 are fixed
up = u;
vp = v;

%surrounding velocities are calculated following the algorythm described in
%the slides
for i=2:N+1
    for j=2:N+1
        uw(i-1,j-1) = up(i-1,j);
        vs(i-1,j-1) = vp(i,j-1);
    end
end

    %only central values are assessed
    up = up(2:N+1,2:N+1);
    vp = vp(2:N+1,2:N+1);


%b matrix is calculated to achieve pseudo_p
b = zeros(N^2,1);

for i=1:N^2
    b(i) = delta*(vp(i)-vs(i)+up(i)-uw(i));
end

%the divergence of the global CV is calculated (has to result 0)
div_u = sum(b);

end