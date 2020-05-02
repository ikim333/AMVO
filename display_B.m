%% DISPLAY B
%this function will display the velocity vectors in each coordinate before
%and after the correction

function display_B (L, delta, coord_u, coord_v, u1, v1, N)

coord_u = flipud(coord_u); %flip coordinates
coord_v = flipud(coord_v);

figure
grid on
hold on
axis([0-2*delta L+2*delta 0-2*delta L+2*delta]) %axis definition
xticks([0-2*delta:delta:L+2*delta]) %axis' ticks defined for each CV
yticks([0-2*delta:delta:L+2*delta])
qu = quiver (coord_u(:,:,1),coord_u(:,:,2),u1,zeros(N+2,N+2)); %vectors
qv = quiver (coord_v(:,:,1),coord_v(:,:,2),zeros(N+2,N+2),v1);
qu.AutoScale = 'off';
qv.AutoScale = 'off';
hold on
plot([0,0],[0,L],'k') %defines global CV
plot([L,0],[0,0],'k')
plot([L,0],[L,L],'k')
plot([L,L],[L,0],'k')
xlabel('x [m]')
ylabel('y [m]')
drawnow
hold off